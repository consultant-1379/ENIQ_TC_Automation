*** Settings ***

Documentation     Validate Netan Database Connect button in Administration page
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Validate Netan Database Connect button in Administration page
	[Tags]       PMEX_CDB       Admin_Page     NetAn_UG_PMEX_TC58
	open pm explorer analysis
	Click on Administration button
	Verify connection status column is successful and ENIQ input field is empty
	Verify Connection status column of single ENIQ Datasource for failed connection
	verify that the connection to NetAn database is made
    Capture page screenshot