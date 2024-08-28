*** Settings ***
Documentation     Verify report creation for'Existing Interval Definition', 'No Aggregation' and 'Collection'
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
Verify Report creation in PMEX for 'Existing Interval Definition', 'No Aggregation' and 'Collection'
    [Tags]     PMEX_CDB          Report_Manager
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUI_Existing_Interval_Definition_No_Aggregation_Collection_Two.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue On Failure    Verify report creation for'Existing Interval Definition', 'No Aggregation' and 'Collection'       ${object}[${key}]
    END    
    
*** keywords ***
Verify report creation for'Existing Interval Definition', 'No Aggregation' and 'Collection'
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Collection Manager button
    Click on Create Collection button
    ${collectName}=    Enter the Collection name
    Select DataSource as    ${data}[Data_source]
    Select System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Click on Fetch Nodes
    Select Nodes    ${data}[Node]
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectName}
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Select Collection    ${collectName}
    Select Aggregation    ${data}[Aggregation]
	click on scroll down button    9    20
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time] 	
	select an existing interval
	Click on fetch pmdata button
	Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Time_title_validation]
	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]    ${data}[Report_Description]
	Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]    ${data}[Report_Description]
    Verify that the report is saved to the DB     ${report_name}  
	[Teardown]       Test teardown steps for webUI