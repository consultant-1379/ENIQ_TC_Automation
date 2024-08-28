*** Settings ***
Documentation     Validate Report Generation using Ignore Null Values feature
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases **
Validate Report Generation using Ignore Null Values feature TCs
    [Tags]     PMEX_CDB          EQEV-125672
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/Validate_Report_Generation_using_Ignore_Null_Values_feature.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
        Run Keyword And Continue On Failure     Validate Report Generation using Ignore Null Values feature    ${object}[${key}]
    END   

*** keywords *** 
Validate Report Generation using Ignore Null Values feature
    [Arguments]      ${data}
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    ${data}[Data_source]
    Select the System area    ${data}[System_area]
    Select Node type    ${data}[Node_type]
    Select Get Data For    ${data}[Get_Data_for]
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    ${data}[Node1]
    Select the Aggregation    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type]
    Select KPIs    ${data}[Measure]
    Select time drop down to      ${data}[Time_selector] 
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]     
	Click on Ignore Null Values check box
    Click on fetch pmdata button
	Verify the page title    ${data}[Aggregation]      ${data}[Data_source]     ${data}[Aggregation_in_select_time]
    Capture page screenshot
	
	
