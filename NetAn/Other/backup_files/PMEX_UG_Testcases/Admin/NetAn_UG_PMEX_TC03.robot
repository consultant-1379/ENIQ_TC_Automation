*** Settings ***

Documentation     Validate SubNetwork List is empty before sync with eniq
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate SubNetwork List is empty before sync with eniq
    [Tags]     Collection_Manager     PMEX_CDB      NetAn_UG_PMEX_TC03
	open pm explorer analysis
	verify that the SubNetwork List is empty
	Click on Administration button
	Connect to DB
	click on Sync with Eniq
	go to Home page
	verify that the SubNetwork List is not empty
	