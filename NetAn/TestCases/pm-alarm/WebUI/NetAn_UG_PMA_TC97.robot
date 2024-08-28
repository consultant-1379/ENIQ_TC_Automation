*** Settings ***

Documentation     Verify Connection Failure Message With Failed DataSource
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

Verify Connection Failure Message With Failed DataSource
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC97
    open pm alarm analysis
    Click On Administration Button
    Connect to DB    localhost    netanserver    wrong_pass    Failed_ODBC
    Navigate to section    Setup Data Source
    Verify after the NetAn Connection is not made "Cannot create connection" message is visible
	verify that if NetAn connection is not made, ENIQ cannection cannot be made
	[Teardown]    Test teardown steps for pmalarm