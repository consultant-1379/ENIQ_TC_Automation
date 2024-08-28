*** Settings ***

Documentation     Verify Report creation with data integrity check box checked
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

*** Test Cases ***

Verify Report creation with data integrity check box checked
    [Tags]       PMEX_CDB           Report_Manager        NetAn_UG_PMEX_TC11
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMExWebUIReport_Input.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    IF     '${count}'=='0'
                Run keyword       Create report with data integrity check box checked       ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Create report with data integrity check box checked       ${object}[${key}]
		END
    END
    
    
    
*** keywords ***

Create report with data integrity check box checked
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
    Check the Data Integrity Check box and Fetch PM Data
    Verify File Availability and counter availability column present
    	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]   ${data}[Report_Description]
	Click on Save report to Library button
        Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]   ${data}[Report_Description]

 