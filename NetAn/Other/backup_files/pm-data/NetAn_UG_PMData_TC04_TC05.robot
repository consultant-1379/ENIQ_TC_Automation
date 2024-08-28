*** Settings ***

Documentation     Verify Alarm Generation
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile} 
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify Alarm Generation
    [Tags]       PMD_CDB
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/MTAS_PMA.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    add test case    MTAS1     Verify alarm generation for threshold alarm       ${object}[MTAS1]

*** Keywords ***   
 
Verify alarm generation for threshold alarm
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
    ${alarm_criteria}=     run keyword and return status    Verify alarm criteria
    PMAlarmWebUI.Click on Save button
    Verify alarm displayed in UI       ${alarm_name}
    ${status}=    run keyword and return status    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Active
	Verify worker files are scheduled for PM Alarm      WorkerAnalysis_1
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2A
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2B
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_3
    #Sleep    600
    #Verify alarm in DC_Z_ALARM_NETAN_RAW      ${alarm_name}     ${alarm_criteria}
    #Verify alarm generated in ENM    ${alarm_name}     ${data}[Node]    ${data}[Probable_cause]     ${alarm_criteria}
	[Teardown]    close browser