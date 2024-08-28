*** Settings ***
Documentation     Testing Core Nodetypes
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
Verify Edit and View Button in Report Manager Page
    [Tags]     PMEX_CDB         Report_Manager
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMExReportInput.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
        IF     '${count}'=='0'
                Run keyword      Validate the Edit and View Button in Report Manager Page      ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}    Validate the Edit and View Button in Report Manager Page       ${object}[${key}]
		END
    END    
    
*** keywords ***
Validate the Edit and View Button in Report Manager Page
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
    Select the measure type   ${data}[Measure_type]
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]    
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Click on fetch pmdata button
	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
	Click on Save report to Library button
	Select the report    ${report_name}
	Click on Edit button
	Verify that the Edit page is visible
	Close the Edit page
	Click on View button
	Verify that the View page is visible
	Close the View Report page

