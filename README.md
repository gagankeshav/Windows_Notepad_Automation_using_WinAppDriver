# windows-notepad-automation-tests
Repo for Automation of Tests for Windows Notepad Application

# Pre-requisites:
1. Ruby should be installed on the system.
2. WinAppDriver should be Installed on the system [Download from: https://github.com/microsoft/WinAppDriver/releases/download/v1.2-RC/WindowsApplicationDriver.msi]
3. WinAppDriver should be running on the system before executing the tests. [To execute, go to install directory e.g. [C:\Program Files (x86)\Windows Application Driver] and execute WinAppDriver.exe]
3. Following gems should be installed on the system:
    - selenium-webdriver
    - faker
    - rspec
    - yaml

To install the gems outlined above, use following command for each gem installation:
- gem install <gem name> e.g. gem install selenium-webdriver

# Executing the tests
Navigate to the tests folder and execute below command to execute the tests:
- rspec notepad_automation.rb --format documentation