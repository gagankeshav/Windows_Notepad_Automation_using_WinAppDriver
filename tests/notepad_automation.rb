# Initial configuration
$LOAD_PATH.unshift File.expand_path('../../', __FILE__)
require 'helpers'

RSpec.describe "KiwiRail Practical Test" do
  context "Notepad Automation Tests" do
    before(:all) do

      # Loading the configuration from config.yml file
      @config = YAML.load_file(File.expand_path('../../config/config.yml', __FILE__))

      # Generate Capabilities hash to launch Notepad
      caps ={platformName: "WINDOWS",
             platform: "WINDOWS",
             deviceName: "WindowsPC",
             app: 'notepad' }

      # Instantiate the driver for the Notepad application
      @driver = Selenium::WebDriver.for(:remote, :url => "http://127.0.0.1:4723", :desired_capabilities => caps )

      # Maximise the Notepad window
      @driver.manage.window.maximize

      # Instantiate the objects to interact with Notepad and the Windows Save File dialog box
      @notepad = NotepadControls.new(@driver)
      @windows = WindowsControls.new(@driver)

      # Prepare the file name and text for the file to be saved to the current working directory
      cwd = Dir.pwd.gsub(/\//, '\\')
      @actual_filename = "#{Faker::Lorem.word}.txt"
      @filename = "#{cwd}\\#{@actual_filename}"
      @message = Faker::Lorem.sentence(word_count: 5)
    end

    it "Validate that user is able to open the notepad application" do
      expect(@driver.title).to eq(@config['untitled_notepad_title'])
    end

    it "Validate that user is able to add text to notepad instance" do
      @notepad.type_into_notepad(@message)
      expect(@notepad.get_notepad_text).to eq(@message)
    end

    it "Validate that user is able to save the file with custom name and location" do
      begin
        @notepad.save_file
        @windows.enter_filename_with_location(@filename)
        @windows.click_save_button

        # To wait for the file to be saved
        sleep 2

        expect(File.exist?(@actual_filename)).to eq(true)
      ensure
        # Ensure that the Notepad window is closed after the file is saved
        @driver.quit
      end
    end

    it "Validate that user is able to open the saved file" do
      begin
        # Directly open the file saved above using below capabilities
        caps ={platformName: "WINDOWS",
               platform: "WINDOWS",
               deviceName: "WindowsPC",
               app: @filename }

        @new_notepad = Selenium::WebDriver.for(:remote, :url => "http://127.0.0.1:4723", :desired_capabilities => caps )
        aggregate_failures do
          expect(@new_notepad.title).to eq("#{@actual_filename} - Notepad")
          expect(NotepadControls.new(@new_notepad).get_notepad_text).to eq(@message)
        end
      ensure
        @new_notepad.quit
      end
    end
  end
end
