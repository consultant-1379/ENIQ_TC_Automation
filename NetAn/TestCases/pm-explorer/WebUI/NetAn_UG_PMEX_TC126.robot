*** Settings ***
Documentation     Delete Button Should Be Disabled If The Connection Is Not Selected
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

Delete Button Should Be Disabled If The Connection Is Not Selected
    [Tags]    PMEX_CDB    Admin_Page
	open pm explorer analysis
	Click on Administration button
	validate that the following button is disabled    Delete
	Capture page screenshot