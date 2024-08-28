*** Settings ***

Documentation     Verify Connection Status Column of Netan Database For Successful Connection
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

Verify Connection Status Column of Netan Database For Successful Connection
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC101
    open pm alarm analysis
    click on administration button
    Navigate to section    Setup Data Source 
    verify that the connection to NetAn is made
    [Teardown]    Test teardown steps for pmalarm