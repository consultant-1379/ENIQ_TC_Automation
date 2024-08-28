*** Settings ***

Documentation     Verify The Selected Eniq Is Present Or Not And Click on Cancel Button
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

Verify The Selected Eniq Is Present Or Not And Click on Cancel Button
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC115
    open pm alarm analysis
	Connect to the DB    4140_ODBC
	validate the page title    Administration
    navigate to section    ENIQ Connection Status
    click on an ENIQ connection and check the Eniq Name and click on cancel
    [Teardown]    Test teardown steps for pmalarm