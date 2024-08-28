*** Settings ***

Documentation     Verify All Latest KPIs Are Available In Measure Mapping Table
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify All Latest KPIs Are Available In Measure Mapping Table
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/POC.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMEx#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
    	add test case    ${key}     Verify All Latest KPIs Are Available In An Analysis       ${object}[${key}]
    END

*** Keywords ***

Verify All Latest KPIs Are Available In An Analysis
    [Tags]    PMD_CDB
    ${formulaMeasures}=    get formula for the KPI    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/POC.json    Failure Ratio for Act Provisioning Service-Service Provider
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Click on scroll down button    6    20
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    click on scroll down button        6      30
    Select Aggregation    ${data}[Aggregation]
    Click on Refresh nodes button
    Select Nodes    ${data}[Node]
    Select the measure type   ${data}[Measure_type]
    Select KPIs    ${data}[Measure]
    put cursor on    Selected Measures
    Click on maximise window button    1
    ${formulaAnalysis}=    read the formula for selected KPI    ${data}[Node_type]
    verify that the formula from Measures.csv matched the formula from Analysis    ${formulaMeasures}    ${formulaAnalysis}