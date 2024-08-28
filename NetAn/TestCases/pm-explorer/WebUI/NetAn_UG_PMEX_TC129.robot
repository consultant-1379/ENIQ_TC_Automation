*** Settings ***
Documentation     Validate Last Successful Sync With Eniq Column In Administration Page
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

Validate Last Successful Sync With Eniq Column In Administration Page
    [Tags]     Admin_Page    PMEX_CDB
	open pm explorer analysis
	Click on Administration button
	${status}=    verify Last Successful Sync With Eniq column and return status
	verify the time and timezone in Last Successful Sync    ${status}
	Capture page screenshot
