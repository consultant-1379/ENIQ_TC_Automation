*** Settings ***

Documentation     Verify The Administration button in Home Page
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

Verify The Administration button in Home Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC92
	open pm alarm analysis
	validate that the button is visible    Administration
	Click on Administration button
	validate the page title    Administration
	[Teardown]    Test teardown steps for pmalarm