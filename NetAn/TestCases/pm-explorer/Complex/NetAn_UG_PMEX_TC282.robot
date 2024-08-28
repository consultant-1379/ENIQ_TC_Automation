*** Settings ***
Documentation     Verify report creation for'Calendar Interval', 'All Selected' and 'Subnetwork'
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

Verify Report creation in PMEX with data 'Calendar Interval', 'All Selected' and 'Subnetwork'
    [Tags]       PMEX      Report_Manager
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMExWebUIReport_CalendarInterval_All_Selected_Subnetwork.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue on Failure    Verify report creation for'Calendar Interval', 'All Selected' and 'Subnetwork'    	${object}[${key}]
	    
    END





*** keywords ***
Verify report creation for'Calendar Interval', 'All Selected' and 'Subnetwork'
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource     ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    select SubNetwork    ${data}[SubNetwork]
    Select the Aggregation    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type]  
    Select KPIs    ${data}[Measure]
    Select time drop down to      ${data}[Time_selector] 
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]   
    Enter the Calendar Interval    01/09/2022    09/09/2022
    Click on fetch pmdata button
    Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}                                                                                                       
    [Teardown]      Test teardown steps for webUI
 