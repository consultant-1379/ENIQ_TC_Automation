*** Settings ***

Documentation	  EQEV-106349 - Verify The PMA Home Page and That The UI Elements Are Visible and Working
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

Verify The Home Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC52    EQEV-106349
	open pm alarm analysis
	verify that the Administration button is visible and working
	verify that the Node Collection Manager button is visible and working
	verify that the Alarm Rules Manager button is visible and working
    [Teardown]    Test teardown steps for pmalarm