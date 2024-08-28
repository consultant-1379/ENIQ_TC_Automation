*** Settings ***

Documentation     Verify CMCC Eniq Connection With Wrong Credentials In Settings Page
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

Verify CMCC Eniq Connection With Wrong Credentials In Settings Page
	[Tags]    CMCC_CDB
	open cmcc analysis
	verify the page title    Home
	verify that the Network Analytics logo is visible
	verify that the Cmcc logo is visible
	verify that the Settings and Reset icons are visible
	Connect to ENIQ with incorrect Credentials
	verify that connection is not made