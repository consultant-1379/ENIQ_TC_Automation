*** Settings ***

Documentation     EQEV-110751 - Verify That A Notification Pops-Up If We Try To Delete A Connection That Is Being Used
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

Verify Connection Deletion Message In Administration Page
    [Tags]    PMA_CDB    NetAn_UG_PMA_TC87    EQEV-110751
	open pm alarm analysis
    Click on Administration button
	Navigate to the section    ENIQ Connection Status
    click on the connected ENIQ and click on delete     NetAn_ODBC
    verify that the selected server cannot be deleted
	[Teardown]    Test teardown steps for pmalarm