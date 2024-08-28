*** Settings ***

Documentation     EQEV-126953 - Verify That A Collection Can Be Deleted If It's Not Being Used By An Alarm
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify That A Collection Can Be Deleted If It's Not Being Used By An Alarm
	[Tags]      PMA_CDB      EQEV-126953    NetAn_UG_PMA_TC30
    open pm alarm analysis with another username    
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Edit_collection
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on scroll down button     0      10
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    Close Browser
    open pm alarm analysis
    Click on Node Collection manager button
    select the created collection and click on delete    ${collection}
	close the delete collection prompt using Cancel button
	select the created collection and click on delete    ${collection}
	close the delete collection prompt using Close button
	select the created collection and click on delete    ${collection}
    Verify that the Collection can be deleted if it's not being used
    [Teardown]    Test teardown steps for pmalarm