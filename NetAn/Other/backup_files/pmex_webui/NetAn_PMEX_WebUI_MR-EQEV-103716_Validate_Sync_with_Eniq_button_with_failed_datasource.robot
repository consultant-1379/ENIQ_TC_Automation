*** Settings ***
Documentation     Validate 'Sync with Eniq' button with connected datasource
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

Validate 'Sync with Eniq' button with connected datasource
    [Tags]     Admin_Page
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	connect to the DB
	verify that the connection to NetAn database is made
	verify that the connection to datasource(s) is made
	click on button    Sync with ENIQ
	verify that sync is done properly
    Capture page screenshot
	