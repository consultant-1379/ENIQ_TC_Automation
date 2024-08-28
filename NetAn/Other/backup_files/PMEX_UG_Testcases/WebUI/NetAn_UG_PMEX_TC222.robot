*** Settings ***
Documentation     Verify report creation for'Existing Interval Definition', 'Cell' and 'Network'
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***
Verify Report creation in PMEX for'Existing Interval Definition', 'Cell' and 'Network'
    [Tags]     PMEX_CDB          Report_Manager
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUI_Existing_Interval_Definition_Cell_Network.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue On Failure   Verify report creation for'Existing Interval Definition', 'Cell' and 'Network'     ${object}[${key}]
    END    
    
*** keywords ***
Verify report creation for'Existing Interval Definition', 'Cell' and 'Network'
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Select Aggregation    ${data}[Aggregation]
	click on scroll down button    9    20
    Select KPIs        ${data}[Measure]
    Select time drop down to      Define Interval    
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time] 
	${intervalName}=    Create an Interval    Interval5    30/09/2022    06/11/2022
	Select time drop down to      ${data}[Time_selector]
	select an interval    ${intervalName}
	Click on fetch pmdata button
	Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]    ${data}[Report_Description]
	Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]    ${data}[Report_Description]
    Verify that the report is saved to the DB     ${report_name}                
	[Teardown]       Test teardown steps for webUI