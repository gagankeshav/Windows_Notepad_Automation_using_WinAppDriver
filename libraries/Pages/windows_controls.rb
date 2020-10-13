class WindowsControls

  def initialize(driver)
    @driver = driver
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'enter_filename_field' => [:xpath, "//*[@AutomationId=\"1001\"]"],
              'save_file_button' => [:name, "Save"]}

  def enter_filename_with_location(filename)
    wait_for_element('enter_filename_field')
    find_element('enter_filename_field').send_keys filename
  end

  def click_save_button
    wait_for_element('save_file_button')
    find_element('save_file_button').click
  end

  def wait_for_element(element)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { find_element(element) }
  end

  def find_element(element)
    @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
  end
end