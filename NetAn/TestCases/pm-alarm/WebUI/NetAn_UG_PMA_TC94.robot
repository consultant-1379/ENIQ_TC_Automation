*** Settings ***

Documentation     Verify Connection Failure Message If Password Is Not Entered
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

Verify Connection Failure Message If Password Is Empty
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC94
    open pm alarm analysis
    Click on Administration button
	Connect to ENIQ with No Password    localhost    netanserver    ${EMPTY}    NetAn_ODBC
    Verify after the NetAn Connection is not made "please provide Value for: NetAn Password" message is visible
	[Teardown]    Test teardown steps for pmalarm