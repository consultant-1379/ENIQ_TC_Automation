*** Settings ***
Documentation     Testing AdminUI web
Library
Library           Selenium2Library
Library           OperatingSystem
Library           RPA.Browser.Selenium
Library           Collections
Library           String
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/PF/Resources/Keywords/AdminUIWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/PF/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps

*** Test Cases ***

Verify the Login page of AdminUI
	Open Browser To Login Page
	Capture page screenshot
	[Teardown]    Test teardown
	
*** Keywords ***
	
Suite setup steps
    Selenium2Library.Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Selenium2Library.Capture page screenshot
	
Test teardown
    Selenium2Library.Capture page screenshot
    Selenium2Library.Close Browser
 
