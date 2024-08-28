*** Settings ***
Documentation     Validate the ObjectAggregation with Cell & GetData For Nodes 
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

Verify Report creation in PMEX  
    [Tags]     PMEX          Report_Manager
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUI_Preceding_Period_Cell_Nodes.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue On Failure    Validate the ObjectAggregation with Cell & GetData For Nodes     ${object}[${key}] 
    END  


*** keywords ***

Validate the ObjectAggregation with Cell & GetData For Nodes 
    [Arguments]     ${data}
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes    ${data}[Node]
    Select the Aggregation    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type]   
    Select KPIs    ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Enter Preceding period     ${data}[Preceding_period]
    Select Preceding Period Units as     ${data}[Preceding_period_units]
    Click on fetch pmdata button
    Verify the page title       ${data}[Aggregation]   ${data}[Data_source]   ${data}[Aggregation_in_select_time]   
	Click on Save Report
    ${report_name}=    Enter details to save report to library    report_    Public     test
    Click on Save report to Library button	
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}   
	[Teardown]       Test teardown steps for webUI
	
	

 