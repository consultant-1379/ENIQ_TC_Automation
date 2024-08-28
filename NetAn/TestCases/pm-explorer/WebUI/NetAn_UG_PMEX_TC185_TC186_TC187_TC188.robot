*** Settings ***
Documentation     Verify Information Link creation  for counter and PDF KPI
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

Verify Information Link creation for PDF KPI
    [Tags]               Report_Manager            PMEX_CDB
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Create Information link for counter and PDF KPI       ${object}[TC03]

Verify Information Link creation for Counter_1
    [Tags]               Report_Manager            PMEX_CDB
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Create Information link for counter and PDF KPI       ${object}[TC04]	
    
Verify Information Link creation for Counter_2
    [Tags]               Report_Manager            PMEX_CDB
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Create Information link for counter and PDF KPI       ${object}[TC08]	

Verify Information Link creation for Counter_3
    [Tags]               Report_Manager            PMEX_CDB
	${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX_MR_EQEV-124498.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run keyword       Create Information link for counter and PDF KPI       ${object}[TC09]	


*** keywords ***

Create Information link for counter and PDF KPI
    [Tags]             Report_Manager
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
    Click on fetch pmdata button
    Verify the page title    ${data}[Aggregation]     ${data}[Data_source]     ${data}[Aggregation_in_select_time]
	click on button    Create Information Link(s)
	validate the page title    Create Information Link(s)
	${InformationLink}=    enter the information link name    InfoLink_${data}[Report_name]
	select a Information Link Storage Location and Save it     PMEX Reports
	Capture page screenshot
	open browser with home page
	Open the information link         ${InformationLink}       ${data}[table_name]
	Check for the Information link data
	${compare_value}=         Convert To Upper Case      ${data}[Aggregation_in_select_time]
	Validate the information link name based on aggregation selection      ${InformationLink}_${data}[table_name]          ${compare_value}
	Verify given column is available and check for the value       ${data}[Columns_displayed]           ${data}[Check_value]
	Capture page screenshot
	