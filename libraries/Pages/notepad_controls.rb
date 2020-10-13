class NotepadControls

  def initialize(driver)
    @driver = driver
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'editor_area' => [:name, "Text Editor"],
              'file_option' => [:name, "File"],
              'save_option' => [:xpath, "//*[@AutomationId=\"3\"]"]}

  def type_into_notepad(message)
    wait_for_element('editor_area')
    find_element('editor_area').send_keys message
  end

  def click_file_option
    wait_for_element('file_option')
    find_element('file_option').click
  end

  def click_save_option
    wait_for_element('save_option')
    find_element('save_option').click
  end

  def save_file
    click_file_option
    click_save_option
  end

  def get_notepad_text
    wait_for_element('editor_area')
    find_element('editor_area').text
  end

  def wait_for_element(element)
    wait = Selenium::WebDriver::Wait.new(timeout: 60)
    wait.until { find_element(element) }
  end

  def find_element(element)
    @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
  end
end