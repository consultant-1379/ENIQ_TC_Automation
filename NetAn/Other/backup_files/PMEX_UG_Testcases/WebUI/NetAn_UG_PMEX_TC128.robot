*** Settings ***
Documentation     Run Sync With Eniq Terminate It And Check If Date Time Is Updated Or Not
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

Run Sync With Eniq Terminate It And Check If Date Time Is Updated Or Not
    [Tags]      Admin_Page      PMEX_CDB
	open pm explorer analysis
	Click on Administration button
	${status}=    verify Last Successful Sync With Eniq column and return status
	verify the time and timezone in Last Successful Sync    ${status}
	click on sync with eniq button
	click on cancel button for sync with eniq
	sleep    15
	verify that the Date Time is not updated    ${status}
	Capture page screenshot
	