*** Settings ***
Documentation     Verify that the Deletion of the Report by Admin user which is created by Non-Owner user
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***
Verify DELETE button in Report Manager page
    [Tags]       Report_Manager	    PMEX_CDB
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMExReportInput.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Run keyword   Validate the DELETE button in Report Manager page    ${object}[${key}]
    END    
    
*** keywords ***
Validate the DELETE button in Report Manager page
    [Arguments]      ${data}
    Open pm explorer analysis with another user
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Select Aggregation    ${data}[Aggregation]
    Click on Refresh nodes button
    Select Nodes    ${data}[Node]
    Select the measure type   ${data}[Measure_type]
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]    
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Click on fetch pmdata button
	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
	Click on Save report to Library button
    Close Browser
    open pm explorer analysis
    Click on Report manager button
	Select the report    ${report_name}
	Click on Delete Report button
	Click on Delete in confirmation window
	Verify that the selected Report is deleted    ${report_name}

