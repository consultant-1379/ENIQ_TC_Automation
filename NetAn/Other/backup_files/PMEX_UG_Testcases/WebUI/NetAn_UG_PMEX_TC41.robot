*** Settings ***

Documentation     Check if Error Message is Displayed if Wrong Credentials are Entered
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

Check if Error Message is Displayed if Wrong Credentials are Entered
    [Tags]     PMEX_CDB     Admin_Page     NetAn_UG_PMEX_TC41
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	Connect to ENIQ with incorrect Credentials
	verify that connection is not made
	Connect to DB
	Verify the error connection status message with empty name/URL
	Connect to DB
	Verify the error connection status message with empty username
	Connect to DB
	Verify the error connection status message with empty password
	Capture page screenshot