*** Settings ***
Documentation     Validate That The Connection To ENIQ Or ENM Servers
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate That The Connection To ENIQ Or ENM Servers
    [Tags]    Admin_Page    PMEX_CDB       NetAn_UG_PMEX_TC82
	open pm explorer analysis
	Click on Administration button
	verify that the connection to NetAn database is made
	Capture page screenshot
	
    

 