*** Settings ***

Documentation     Verify The Node Collection Manager In Home Page
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

Verify The Node Collection Manager In Home Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC90
	open pm alarm analysis
	verify that the button is visible    Node Collection Manager
	Click on Node Collection manager button
	Validate the page title    Node Collection Manager
	[Teardown]    Test teardown steps for pmalarm