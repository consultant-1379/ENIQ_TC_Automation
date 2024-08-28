*** Settings ***

Documentation     Verify CMCC Edit Button for Rule
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

Verify CMCC Filters In CM Rule Manager
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	Verify filters in CM Rule Manager
	Verfiy Date panels