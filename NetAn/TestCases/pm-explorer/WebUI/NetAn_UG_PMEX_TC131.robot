*** Settings ***
Documentation     Validate The Administration Page
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

Validate The Administration Page
    [Tags]    Admin_Page    PMEX_CDB
	open pm explorer analysis
	Click on Administration button
	verify connection status in DWHDB Connection Status
	verify connection status in REPDB Connection Status
	verify Last Successful Sync With Eniq column
	Capture page screenshot
	