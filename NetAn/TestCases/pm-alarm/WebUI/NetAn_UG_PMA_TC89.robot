*** Settings ***

Documentation     Verify The Alarm Rules Manager In Home Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Verify The Alarm Rules Manager In Home Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC89
	open pm alarm analysis
	verify that the button is visible    Alarm Rules Manager
	Click on Alarm rules manager button
	Validate the page title    Alarm Rules Manager
	verify that the button is visible    Home
	verify that the button is visible    Settings
	Go to Home page
	Validate the page title    Home
	Click on Alarm rules manager button
	Validate the page title    Alarm Rules Manager
	Click on Settings button
	Validate the page title    Administration
	[Teardown]    Test teardown steps for pmalarm