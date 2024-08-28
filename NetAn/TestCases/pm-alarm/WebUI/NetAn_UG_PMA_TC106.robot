*** Settings ***

Documentation     Verify The Delete Action And Message After Deletion Of ENIQ Connection
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

Verify The Delete Action And Message After Deletion Of ENIQ Connection
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC106
    open pm alarm analysis
    Click on Administration button
    validate the page title    Administration
	Connect to DB     localhost       netanserver      Ericsson01     Delete_ODBC
    navigate to section    ENIQ Connection Status
    click on delete button to delete an Eniq connection
    Verify The Delete Dialoge is shown after deletion of an Eniq server     
    [Teardown]    Test teardown steps for pmalarm