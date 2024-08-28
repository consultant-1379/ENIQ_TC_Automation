*** Settings ***

Documentation     Verify The Image In Home Page
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

Verify The Image In Home Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC91
	open pm alarm analysis
	verify that PMA opened up without any error/warnings
	validate that the home page image is present
	[Teardown]    Test teardown steps for pmalarm