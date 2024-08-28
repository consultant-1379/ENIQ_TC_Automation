*** Settings ***
Documentation     Report Creation for multiple measure type
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

Verify Report creation for multiple measure type combination
    [Tags]       PMEX_CDB        Report_Manager
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUI_MeasureType_Combination.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue on Failure    Report Creation with different measure type combination        ${object}[${key}]	    
    END





*** keywords ***
Report Creation with different measure type combination
    [Arguments]      ${data}   
    open pm explorer analysis
    Click on Report Manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes    ${data}[Node_1]
    Select Aggregation as    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type_1],${data}[Measure_type_2]
    Select KPIs    ${data}[Measure_1],${data}[Measure_2],${data}[Measure_3]
    Select time drop down to      ${data}[Time_selector] 
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]
    Enter Preceding period     ${data}[Preceding_period]
    Select Preceding Period Units as     ${data}[Preceding_period_units]
    Enter the time period details         ${data}[Number]      ${data}[Month]
    Click on fetch pmdata button
    Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
	Verify that the Report has data  
	Navigate to next page and verify the data     ${data}[Page_Name]    
	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]    ${data}[Report_Description]
	Click on Save report to Library button
	select the created report    ${report_name}
    Click on Edit button
    Verify that the Edit page is visible
	Click on Refresh nodes button
    Select Nodes in edit mode         ${data}[Node_2]
    Click on update pmdata button   
    Verify updated node updated in edit mode         ${data}[Node_2]