*** Settings ***
Documentation     Verify Report creation in PMEX
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***
Verify Report creation in PMEX
    [Tags]       PMEX_KGB      Report_Manager    NetAn_UG_PMEX_TC56
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUIUseCase.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    IF     '${count}'=='0'
                Run keyword       Verify report creation       ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Verify report creation       ${object}[${key}]
		END
    END

    
    
*** keywords ***
Verify report creation connection
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    ${data}[Data_source]
    Select System area as    ${data}[System_area]
    Select Node type as    ${data}[Node_type]
    Select Get Data For as    ${data}[Get_Data_for]
    Select Aggregation as    ${data}[Aggregation]
    Click on Refresh nodes button
    Select Nodes as    ${data}[Node]
    Select the measure type   ${data}[Measure_type]
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]    
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Click on fetch pmdata button
    Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
    Verify columns displayed    ${data}[Columns_displayed] 
    ${measure_value}=    Get cell value       ${data}[Measure]    1
    Verify Dataintegrity of the Measure       ${data}[get_data_for_Columns]       ${data}[Formula]      ${data}[Measure]

Verify report creation
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    ${data}[Data_source]
    Select System area as    ${data}[System_area]
    Select Node type as    ${data}[Node_type]
    Select Get Data For as    ${data}[Get_Data_for]
    Click on Refresh nodes button
    Select Nodes as    ${data}[Node]
    Select Aggregation as    ${data}[Aggregation]
    Select the measure type   ${data}[Measure_type]
    Select KPIs        ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]    
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Click on fetch pmdata button
    Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
    Verify columns displayed    ${data}[Columns_displayed] 
    #${measure_value}=    Get cell value       ${data}[Measure]    1
    #Verify Dataintegrity of the Measure       ${data}[get_data_for_Columns]       ${data}[Formula]      ${data}[Measure]
    Click Save report button
    ${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]   ${data}[Report_Description]
    Verify that the report is saved to the DB     ${report_name}
    

