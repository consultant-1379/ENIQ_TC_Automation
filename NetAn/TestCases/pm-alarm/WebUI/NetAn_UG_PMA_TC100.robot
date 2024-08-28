*** Settings ***

Documentation     Verify ENIQ Connection Status in Administration Page
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

Verify ENIQ Connection Status in Administration Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC100
    open pm alarm analysis
    click on administration button
    Navigate to section    Setup Data Source 
    verify that connection to Eniq is made
    Verify after the Eniq Connection is made "Connection" message is visible
	[Teardown]    Test teardown steps for pmalarm