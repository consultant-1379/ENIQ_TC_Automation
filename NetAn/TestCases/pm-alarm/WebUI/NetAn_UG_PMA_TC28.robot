*** Settings ***

Documentation     EQEV-108162 - Verify Delete Collection Button and Deletion Confirmation Message in Node Collection Manager Page
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot   

*** Test Cases ***

Verify Delete Collection Button in Node Collection Manager page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC28
    open pm alarm analysis    
    Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Click on Create collection button
    ${collection}=     Enter Collection name         Edit_collection
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    select the created collection and click on delete    ${collection}
    Verify that the deletion verification message is visible
	[Teardown]    Test teardown steps for pmalarm