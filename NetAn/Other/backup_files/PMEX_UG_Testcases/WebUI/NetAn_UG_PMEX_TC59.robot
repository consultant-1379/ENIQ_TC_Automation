*** Settings ***
Documentation     Validate Netan Datasource Connect button in Administration page for Single and Multi Eniq
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

Validate Netan Datasource Connect button in Administration page for Single and Multi Eniq
    [Tags]     Admin_Page         PMEX_CDB    NetAn_UG_PMEX_TC58
	open pm explorer analysis
	Click on Administration button
	verify that the connection to NetAn database is made
	verify that the connection to datasource(s) is made
    Capture page screenshot
	