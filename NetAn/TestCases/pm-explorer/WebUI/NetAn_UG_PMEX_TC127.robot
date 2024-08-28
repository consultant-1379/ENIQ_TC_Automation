*** Settings ***
Documentation     Validate Last Successful Sync With Eniq Date And Time Should Remain After Connection Is Refreshed
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

Validate Last Successful Sync With Eniq Date And Time Should Remain After Connection Is Refreshed
    [Tags]      PMEX_CDB    Admin_Page
	open pm explorer analysis
	Click on Administration button
	${status}=    verify Last Successful Sync With Eniq column and return status
	verify the time and timezone in Last Successful Sync    ${status}
	enter a false datasource and click on connect    4140_ODBC
	verify that after connection refreshed the LastSuccessful Sync time remains same    ${status}
	Capture page screenshot
	