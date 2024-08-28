*** Settings ***
Documentation     Validate static and Dynamic collection in Collection Manager page
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
      

*** Test Cases ***

Validate static and Dynamic collection in Collection Manager page
	[Tags]      PMA_CDB    NetAn_UG_PMA_TC12
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_Collection_manager.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run Keyword And Continue on Failure     Validate static collection       ${object}[TC01]
    Run Keyword And Continue on Failure     Validate Dynamic collection      ${object}[TC02]
    

*** Keywords ***
	
Validate static collection
    [Arguments]       ${data}
    open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         ${data}[Collection_name]
    Select ENIQ Data Source in collection manager        ${data}[ENIQ_data_source]
    Select System area for collection manager and verify none value is not present        ${data}[System_area]
    Verify if the fetch nodes and import nodes from file should be disabled before selecting Node Type and System Area
    Select Node type for collection manager        NR
    Verify if the fetch nodes and import nodes from file should be enabled after selecting Node Type and System Area
    Select the Collection type        ${data}
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       ${data}[Node]
    Click on Create button
    Verify collection is displayed in collection manager UI       ${data}       ${collection}
       
    
Validate Dynamic collection
    [Arguments]       ${data}
    open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         ${data}[Collection_name]
    Select ENIQ Data Source in collection manager        ${data}[ENIQ_data_source]
    Select System area for collection manager and verify none value is not present        ${data}[System_area]
    Verify if the fetch nodes and import nodes from file should be disabled before selecting Node Type and System Area
    Select Node type for collection manager             ${data}[Node_type]    
    Verify if the fetch nodes and import nodes from file should be enabled after selecting Node Type and System Area
    Select the Collection type        ${data}
    click on Preview button
    Click on Create button
    Verify collection is displayed in collection manager UI       ${data}       ${collection}