*** Settings ***
Documentation     EQEV-139381 - Verify Information Link creation for multi table kip's and union kpi and KPI which has period duration
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verify Information Link creation for multi table and union KPI's
    [Tags]       PMEX_CDB        Report_Manager    EQEV-139381
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUI_Multi_Union_KPI.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue on Failure    Validate Information Link creation        ${object}[${key}]	    
    END


*** keywords ***
Validate Information Link creation
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
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]
    Click on Ignore Null Values check box
    Click on fetch pmdata button
	click on information link button
	validate the page title    Create Information Link(s)
	${InformationLink}=    enter the information link name    InfoLink_${data}[IL_Name]
	select a Information Link Storage Location and Save it     PMEX Reports
	Capture page screenshot
	open browser with home page
	Open the information link         ${InformationLink}       ${data}[table_name]
	Verify given column is available and check for the value       ${data}[Columns_displayed]           ${data}[Check_value]
	Capture page screenshot
	[Teardown]     Close Browser
	