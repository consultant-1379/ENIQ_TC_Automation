*** Settings ***
Documentation     Check if error message shows for incorrect credentials for connection to NetAn database
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  SikuliLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Check if error message shows for incorrect credentials
    [Tags]     PMEX_CDB      Admin_Page            NetAn_UG_PMEX_TC38
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	Connect to the DB with wrong credentials
	verify that the connection to NetAn database is not made
	Capture page screenshot
