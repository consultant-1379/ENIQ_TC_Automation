*** Settings ***
Documentation     Testing Core Nodetypes
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


      


*** Test Cases ***
Verify alarm generation for single node
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_WebUI_Alarm_verification_singlenode.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
		IF     '${count}'=='0'
			IF      '${object}[${key}][Alarm_Type]'=='Threshold'  
				   Run keyword       Verify alarm generation for threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection + Continuous Detection'
				   Run keyword       Verify alarm generation for pcd_cd alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Case Dependent Threshold'
				   Run keyword       Verify alarm generation for threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Dynamic Threshold'
				   Run keyword       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Continuous Detection'
				   Run keyword       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection'
				   Run keyword        Verify alarm generation for Past Comparison Detection alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Trend' 
				   Run keyword       Verify alarm generation for dynamic threshold alarm        ${object}[${key}]
				   ${count}=       set variable     1
			END 
        ELSE
		    IF      '${object}[${key}][Alarm_Type]'=='Threshold'  
				   Add Test Case    ${key}   Verify alarm generation for threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection + Continuous Detection'
				   Add Test Case    ${key}   Verify alarm generation for pcd_cd alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Case Dependent Threshold'
				   Add Test Case    ${key}   Verify alarm generation for threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Dynamic Threshold'
				   Add Test Case    ${key}   Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Continuous Detection'
				   Add Test Case    ${key}   Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection'
				   Add Test Case    ${key}   Verify alarm generation for Past Comparison Detection alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Trend' 
				   Add Test Case    ${key}   Verify alarm generation for dynamic threshold alarm        ${object}[${key}]
			END 
		END	
    
    END

*** Keywords ***   
    

Verify alarm generation for pcd_cd alarm
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
    Select Look back period unit as      ${data}[LookBack_Period_unit]
    Enter Look back period    ${data}[LookBack_Period_val]
    Select Date range unit as      ${data}[Date_range_unit]
    Enter Date range     ${data}[Date_range_val]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    PMAlarmWebUI.Verify alarm title      ${alarm_name}
    Verify columns displayed    ${data}[Columns_diplayed]
    Verify data integrity of measures      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]      
	${alarm_criteria}=     Verify alarm criteria
    PMAlarmWebUI.Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Active  
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_1
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2A
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2B
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_3	
    Sleep    600s
    Verify alarm in DC_Z_ALARM_NETAN_RAW      ${alarm_name}     ${alarm_criteria}
    Verify alarm generated in ENM    ${alarm_name}     ${data}[Node]    ${data}[Probable_cause]     ${alarm_criteria}
       
    
    
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
    Verify data integrity of measures      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]      
	${alarm_criteria}=     Verify alarm criteria
    PMAlarmWebUI.Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Active
	Verify worker files are scheduled for PM Alarm      WorkerAnalysis_1
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2A
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2B
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_3
    Sleep    600s
    Verify alarm in DC_Z_ALARM_NETAN_RAW      ${alarm_name}     ${alarm_criteria}
    Verify alarm generated in ENM    ${alarm_name}     ${data}[Node]    ${data}[Probable_cause]     ${alarm_criteria}
       
    

Verify alarm generation for dynamic threshold alarm
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
    Select Date range unit as      ${data}[Date_range_unit]
    Enter Date range     ${data}[Date_range_val]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    PMAlarmWebUI.Verify alarm title      ${alarm_name}
    Verify columns displayed    ${data}[Columns_diplayed] 
    Verify data integrity of measures      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]      
	${alarm_criteria}=     Verify alarm criteria
    PMAlarmWebUI.Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Active
	Verify worker files are scheduled for PM Alarm      WorkerAnalysis_1
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2A
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2B
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_3
    Sleep    600s
    Verify alarm in DC_Z_ALARM_NETAN_RAW      ${alarm_name}     ${alarm_criteria}
    Verify alarm generated in ENM    ${alarm_name}     ${data}[Node]    ${data}[Probable_cause]     ${alarm_criteria}
       
    
Verify alarm generation for Past Comparison Detection alarm
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
    Select Look back period unit as      ${data}[LookBack_Period_unit]
    Enter Look back period    ${data}[LookBack_Period_val]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    PMAlarmWebUI.Verify alarm title      ${alarm_name}
    Verify columns displayed    ${data}[Columns_diplayed] 
    Verify data integrity of measures      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]      
	${alarm_criteria}=     Verify alarm criteria
    PMAlarmWebUI.Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    PMAlarmWebUI.Verify alarm state in DB      ${alarm_name}     Active
	Verify worker files are scheduled for PM Alarm      WorkerAnalysis_1
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2A
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2B
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_3
    Sleep    600s
    Verify alarm in DC_Z_ALARM_NETAN_RAW      ${alarm_name}     ${alarm_criteria}
    Verify alarm generated in ENM    ${alarm_name}     ${data}[Node]    ${data}[Probable_cause]     ${alarm_criteria}
       
   

    
    


    
    


    