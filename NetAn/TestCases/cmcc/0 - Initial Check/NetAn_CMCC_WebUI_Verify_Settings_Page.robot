*** Settings ***

Documentation     Verify CMCC Settings Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${CMCCKeywordsFile}

*** Test Cases ***

Verify CMCC Settings Page
	[Tags]    CMCC_CDB
	open cmcc analysis
	verify the page title    Home
	verify that the Network Analytics logo is visible
	verify that the Cmcc logo is visible
	verify that the Settings and Reset icons are visible
	click on button    Settings
	verify the page title    Administration Settings
	click on button    CM Rule Manager
	verify the page title    CM Rule Manager
	click on button    Settings
	verify the page title    Administration Settings
	click on button    Return Home