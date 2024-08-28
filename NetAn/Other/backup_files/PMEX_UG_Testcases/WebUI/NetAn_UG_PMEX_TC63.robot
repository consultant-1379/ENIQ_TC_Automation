*** Settings ***
Documentation     Validate_error_message_shows_for_failed_datasource_for_sync_with_eniq
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

Validate_error_message_shows_for_failed_datasource_for_sync_with_eniq
	[Tags]    PMEX_CDB         Admin_Page      NetAn_UG_PMEX_TC63
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	Connect to Multiple ENIQs
	Connect to Failed DB
	click on button    Sync with ENIQ
	verify that the connection failed for Multiple datasource
    Capture page screenshot

 