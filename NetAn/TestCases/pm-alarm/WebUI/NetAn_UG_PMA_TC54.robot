*** Settings ***

Documentation     EQEV-106349 - Validate That The Connection To ENIQ Or ENM Is Successful
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

Validate That The Connection To ENIQ Or ENM Is Successful
	[Tags]    PMA    NetAn_UG_PMA_TC54    EQEV-106349
	open pm alarm analysis
	verify that the Administration button is visible and working
	verify that the Node Collection Manager button is visible and working
	verify that the Alarm Rules Manager button is visible and working
	Click on Administration button
	verify that the connection to ENIQ is made
	Set up ENM connection
	verify that the connection to ENM is made
	[Teardown]    Test teardown steps for pmalarm