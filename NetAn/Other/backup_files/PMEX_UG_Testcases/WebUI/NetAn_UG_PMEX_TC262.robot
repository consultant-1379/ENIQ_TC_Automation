*** Settings ***
Documentation     Report creation with different time aggregation input with combination of  Last 30 Days Period_get data for Collection_AllSelected aggregation
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py


*** Test Cases ***

Create Report with collectin, AllSelected aggregation and last 30 days combination
    [Tags]       PMEX           Report_Manager        
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXWebUI_Last30days_AllSelected_Collection.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
       Run keyword And Continue On Failure     Report creation for combination of Last 30 Days Period_get data for Collection_AllSelected aggregation       ${object}[${key}]

    END
    
    
    
*** keywords ***    
Report creation for combination of Last 30 Days Period_get data for Collection_AllSelected aggregation
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Collection Manager button
    Click on Create Collection button
    ${collectName}=    Enter the Collection name
    Select DataSource as    ${data}[Data_source]
    Select System area    ${data}[System_area]
    Select Node type as for collection Manager    ${data}[Node_type]
    Click on Fetch Nodes
    Select Nodes    ${data}[Node1]
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
	Select Aggregation as    ${data}[Aggregation]
    Select the measure type    ${data}[Measure_type]   
    Select KPIs    ${data}[Measure]
    Select time drop down to      ${data}[Time_selector]  
    Select Aggregation in select time as     ${data}[Aggregation_in_select_time]  
    Click on fetch pmdata button
	Click on Save Report
	${report_name}=    Enter details to save report to library    ${data}[Report_name]    ${data}[Report_AccessType]    ${data}[Report_Description]
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    ${data}[Report_AccessType]    ${data}[Report_Description]
    Verify that the report is saved to the DB     ${report_name}        
	[Teardown]       Test teardown steps for webUI

 