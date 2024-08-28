*** Settings ***

Documentation     Validate Static collection
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Static collection
    [Tags]       PMEX_KGB       Report_Manager
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMExWebUICollectionInput.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Validate Static collection in Collection Manager page    ${object}[TC01]  
    
*** keywords ***

Validate Static collection in Collection Manager page
    [Arguments]    ${data}
    open pm explorer analysis
    Click on Collection Manager button
    Click on Create Collection button
    ${collectName}=    Enter the Collection name
    Select DataSource as    ${data}[Data_source]
    Select System area    ${data}[System_Area]
    click on the scroll down button    6    7
    Select Node type    ${data}[Node_Type]
    Click on scroll down button    6    20
    Click on Fetch Nodes
    Select Nodes    ${data}[Node]
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectName} 

