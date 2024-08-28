*** Settings ***

Documentation     EQEV-110751 - Verify The Alarm Types In Alarm Rule Manager Page
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Verify The Alarm Types In Alarm Rule Manager Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC59    EQEV-110751
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    Click on Alarm type and verify the list of alarm types
	[Teardown]    Test teardown steps for pmalarm