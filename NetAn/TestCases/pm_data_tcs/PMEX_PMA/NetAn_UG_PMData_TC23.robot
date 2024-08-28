*** Settings ***
Documentation     Verify Report creation in PMEX for cNELS Counters
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot     



*** Test Cases ***
Verify Report creation in PMEX for NR Counters
    [Tags]     PMD_CDB      EQEV-125465      NetAn_UG_PMData_TC23        
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/FlexDynV_PMEx_DataIntegerity.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue On Failure   Verify report creation in PMEX for NR Counters     ${object}[${key}]
    END    
    
*** keywords ***
Verify report creation in PMEX for NR Counters
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes    ${data}[Node]
    Select Aggregation    ${data}[Aggregation]
	click on scroll down button    9    20
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time] 	
	Click on fetch pmdata button
	Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]

    Verify integrity of new counter type      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]      
	
    Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]    ${data}[Report_Description]
	Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]    ${data}[Report_Description]   
	[Teardown]       Test teardown steps for webUI