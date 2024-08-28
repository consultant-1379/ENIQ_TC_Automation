*** Settings ***
Documentation     Verfiy that the Connected Data Sources are Listing in Select ENIQ DataSource Dropdown
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verfiy that the Connected Data Sources are Listing in Select ENIQ DataSource Dropdown
    [Tags]    Report_Manager	PMEX_CDB            NetAn_UG_PMEX_TC76
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    verify that the connected DataSource is present    NetAn_ODBC
    Capture page screenshot
	
