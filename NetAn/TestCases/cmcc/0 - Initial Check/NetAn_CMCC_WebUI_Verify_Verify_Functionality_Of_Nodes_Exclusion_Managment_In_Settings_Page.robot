*** Settings ***

Documentation     Verify CMCC Functionality Of Nodes Exclusion Managment In Settings Page
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

Verify CMCC Functionality Of Nodes Exclusion Managment In Settings Page
	[Tags]    CMCC_CDB
	open cmcc analysis
	verify the page title    Home
	verify that the Network Analytics logo is visible
	verify that the Cmcc logo is visible
	verify that the Settings and Reset icons are visible
	click on button    Settings
	verify that the connection to NetAn database is made
	verify that the connection to datasource(s) is made
	Enter Node Name in Node Exclusion Field    Nr05
	click on button    Add Excluded Node
	Verify Node is added in Node exclusion List    Nr05
	Select Node in Node exclusion List    Nr05
	click on button    Remove Excluded Nodes
	Verify Node is removed in Node exclusion List    Nr05