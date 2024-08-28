*** Settings ***
Documentation     Validate ModifiedBy Column In Report Manager Page
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

Validate ModifiedBy Column In Report Manager Page
    [Tags]      Report_Manager    PMEX_CDB            NetAn_UG_PMEX_TC33
	open pm explorer analysis
	Click on Report manager button
	validate the page title    Report Manager
	verify that the column ModifiedBy is present in Report Manager page
	Capture page screenshot
	