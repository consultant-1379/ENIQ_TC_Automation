*** Settings ***

Documentation     Verify Error message with Wrong Eniq database
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

Verify Error message with Wrong Eniq database
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC103
    open pm alarm analysis
    click on administration button
    Connect to ENIQ with wrong Eniq_ODBC    localhost    netanserver     Ericsson01    Wrong_ODBC
    Verify after the Eniq Connection is made "failed to connect with: "Wrong_ODBC" message is visible
    [Teardown]    Test teardown steps for pmalarm