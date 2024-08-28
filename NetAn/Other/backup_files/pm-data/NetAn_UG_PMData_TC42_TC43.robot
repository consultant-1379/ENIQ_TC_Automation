*** Settings ***

Documentation     Verify DataIntegrity Of The Measure In PMEx
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}   
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Verify DataIntegrity Of The Measure In PMEx
    [Tags]       PMD_CDB
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/PCC_SQL.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    add test case    PCC_KPI_PMEX     Verify Data Integrity of The Measure       ${object}[PCC_KPI_PMEX]
    
*** keywords ***

Verify Data Integrity of The Measure
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    ${data}[Data_source]
    Select System area as    ${data}[System_area]
    Select Node type as    ${data}[Node_type]
    Select Get Data For as    ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes as    ${data}[Node]
    Select Aggregation as    ${data}[Aggregation]
    Select the measure type   ${data}[Measure_type]
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Click on fetch pmdata button
    Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
    Verify columns displayed    ${data}[Columns_displayed] 
    ${measure_value}=    Get cell value       ${data}[Measure]    1
    Click Save report button
    ${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]   ${data}[Report_Description]
    [Teardown]    close browser