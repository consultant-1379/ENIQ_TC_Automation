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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}   
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py

*** Test Cases ***

Verify All Latest KPIs Are Available In Measure Mapping Table
    [Tags]       PMD_CDB
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/PCC_SQL.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    add test case    PCC_KPI_PMEX     Verify All Latest KPIs Are Available In An Analysis       ${object}[PCC_KPI_PMEX]

*** Keywords ***

Verify All Latest KPIs Are Available In An Analysis
    [Arguments]    ${data}
    ${formulaMeasures}=    get formula for the KPI    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/PCC_SQL.json    Network Initiated Service Request Failure Ratio
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Click on scroll down button    6    20
    Select Node type    ${data}[Node_type]
    Select the measure type   ${data}[Measure_type]
    Select KPIs    ${data}[Measure]
    put cursor on    Selected Measures
    Click on maximise window button    1
    ${formulaAnalysis}=    read the formula for selected KPI    ${data}[Node_type]
    verify that the formula from Measures.csv matched the formula from Analysis    ${formulaMeasures}    ${formulaAnalysis}
	[Teardown]    close browser