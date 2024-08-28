*** Settings ***

Documentation       Edit Single and Multi table PDF KPI by updating nodename
Library           AutoItLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Edit single table PDF KPI by updating nodename
    [Tags]             Report_Manager        PMEX_CDB
	${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Edit Nodename for PDF KPI and check for update of node and KPI column       ${object}[TC05]
            
Edit multi table PDF KPI by updating nodename
    [Tags]             Report_Manager         PMEX_CDB
	${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Edit Nodename for PDF KPI and check for update of node and KPI column       ${object}[TC06]   
	
*** keywords ***

Edit Nodename for PDF KPI and check for update of node and KPI column
    [Arguments]      ${data}
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes as         ${data}[Node_1]
    Select the Aggregation    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type]
    Select KPIs    ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]   ${data}[Report_Description]
    select the created report    ${report_name}
    Click on Edit button
    Verify that the Edit page is visible
	Click on Refresh nodes button
    Select Nodes in edit mode         ${data}[Node_2]
    Click on update pmdata button   
    Verify updated node updated in edit mode         ${data}[Node_2]  
    Verify given column is available and check for the value        ${data}[Measure]        .
    Capture page screenshot