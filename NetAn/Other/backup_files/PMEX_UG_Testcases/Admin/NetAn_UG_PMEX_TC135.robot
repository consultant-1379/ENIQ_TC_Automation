*** Settings ***

Documentation     Validate Last Successful Sync With Eniq Date And Time Is The Server Time
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

*** Test Cases ***

Validate Last Successful Sync With Eniq Date And Time Is The Server Time
    [Tags]     PMEX_CDB          Admin_Page        NetAn_UG_PMEX_TC135
	open pm explorer analysis
	Click on Administration button
	Connect to DB
	verify that LastSuccessfulSync column is empty before sync with ENIQ
	click on Sync with Eniq
	sleep    5s
	${status}=    verify Last Successful Sync With Eniq column and return status	
	verify that the Time read from Eniq DS table is the server's time     ${status}
	verify that Remove button is enabled for single selection in DataSources
	Capture page screenshot
	