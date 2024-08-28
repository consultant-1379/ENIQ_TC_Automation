*** Settings ***

Documentation     Verify CMCC Functionality Of Remove Excluded Node Button In Settings Page
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

Verify CMCC Functionality Of Remove Excluded Node Button In Settings Page
	[Tags]    CMCC_CDB
	open cmcc analysis
	verify the page title    Home
	click on button    Settings
	Enter Node Name in Node Exclusion Field    ERBS05
	click on button    Add Excluded Node
	click on Remove Excluded Nodes button to get error
	verify error message should be displayed for Remove button