*** Settings ***
Documentation     Verify PDF KPI column is present in fetched data
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Verify Report creation for single table PDFKPI
    [Tags]             Report_Manager          PMEX_CDB
	${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Create report for PDFKPI and Validate KPI Column present and check for the value       ${object}[TC01]
            
Verify Report creation for multi table PDFKPI
    [Tags]             Report_Manager          PMEX_CDB
	${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Create report for PDFKPI and Validate KPI Column present and check for the value       ${object}[TC02]


*** keywords ***

Create report for PDFKPI and Validate KPI Column present and check for the value
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For     ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes     ${data}[Node]
    Select the Aggregation    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type]
    Select the KPIs      ${data}[Measure]
    Validate PDFKPI listed under Ericsson_KPI measure type     ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]
    Click on fetch pmdata button
    Verify Pivot table is created      NetAn_ODBC_PDF
    Verify given column is available and check for the value       ${data}[Measure]       .
    Click on Save Report
	${report_name}=    Enter details to save report to library     ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]   ${data}[Report_Description]
	Verify measure type is stored as Ericsson KPI for instrumentation in data base        ${data}[Measure]
	

