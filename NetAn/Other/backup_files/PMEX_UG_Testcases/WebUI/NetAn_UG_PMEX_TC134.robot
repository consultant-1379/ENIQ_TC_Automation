*** Settings ***
Documentation     Verify That If Either DWHDB Or REPDB Connection Failed The Server Is Considered Failed
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

Verify That If Either DWHDB Or REPDB Connection Failed The Server Is Considered Failed
    [Tags]    PMEX_CDB          Admin_Page
	open pm explorer analysis
	Click on Administration button
	Connect to Failed DB
	verify that connection to FailedDB failed and server is considered failed
	Capture page screenshot
	