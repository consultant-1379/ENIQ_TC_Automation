*** Settings ***

Documentation     Verify Alarm Criteria
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify Alarm Criteria
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/POC.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMA#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
    	add test case    ${key}     Verify alarm criteria for threshold alarm       ${object}[${key}]
    END

*** Keywords ***   
 
Verify alarm criteria for threshold alarm
    [Arguments]      ${data}
	open pm alarm analysis    
    Click on Alarm rules manager button
    PMAlarmWebUI.Click on Create button
    ${alarm_name}=      Prepare alarm name     ${data}[Alarm_name]
    Select alarm type as     ${data}[Alarm_Type]
    Select ENIQ Data Source as     ${data}[ENIQ_data_source]
    Select Single node or Collection or Subnetwork     ${data}[Single_node_or_collection_or_network]
    Select System area as      ${data}[System_area]
    Select Node type as       ${data}[Node_type]
    Click on fetch nodes button
    Select Nodes as      ${data}[Node]
    Select Measure type as     ${data}[Measure_type]
    Select measures    ${data}[Measure]
    Select Alarm severity as      ${data}[Alarm_severity]
    Select Aggregation as      ${data}[Aggregation]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    PMAlarmWebUI.Verify alarm title      ${alarm_name}
    Verify columns displayed    ${data}[Columns_diplayed] 
    Verify data integrity of measures      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]      
	${alarm_criteria}=     Verify alarm criteria
