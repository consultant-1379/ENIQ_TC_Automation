*** Settings ***

Documentation     Verify SubNetwork Viewer Panel Should Be Empty Before Sync With ENIQ
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Verify SubNetwork Viewer Panel Should Be Empty Before Sync With ENIQ
	[Tags]   PMA_CDB     NetAn_UG_PMA_TC150
    open pm alarm analysis
	click on Node Collection manager button
    verify that the SubNetwork List table is empty
	[Teardown]    Test teardown steps for pmalarm