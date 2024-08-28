*** Settings ***

Documentation     Validate 'Delete' button in Administration Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Validate 'Delete' button in Administration Page
	[Tags]       PMEX_CDB       Admin_Page     NetAn_UG_PMEX_TC48
	open pm explorer analysis
	Click on Administration button
	verify that the home icon is visible
    Connect to Multiple ENIQs
	verify that the connection to NetAn database is made
	verify that the connection to datasource(s) is made
	delete the datasource    4140_ODBC
	verify that the datasource is deleted    4140_ODBC
    Capture page screenshot