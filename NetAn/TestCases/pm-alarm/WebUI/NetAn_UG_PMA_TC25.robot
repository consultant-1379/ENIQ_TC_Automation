*** Settings ***

Documentation     Validate Alarm Generation For "Measure Type": "RI, Counter And KPI" Combination In Alarm Rule Manager Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
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

Validate the "Measure Type": "RI, Counter and KPI" combination list in Alarm Rule Manager page
	[Tags]    PMA_CDB          NetAn_UG_PMA_TC25
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_RI_Counter_KPI_WebUI.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    	IF      '${object}[${key}][Alarm_Type]'=='Threshold'  
				   Run Keyword And Continue On Failure       Verify alarm generation for threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection + Continuous Detection'
				   Run Keyword And Continue On Failure        Verify alarm generation for pcd_cd alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Case Dependent Threshold'
				   Run Keyword And Continue On Failure       Verify threshold alarm generation for SubNetwork       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Dynamic Threshold'
				   Run Keyword And Continue On Failure       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Continuous Detection'
				   Run Keyword And Continue On Failure       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection'
				   Run Keyword And Continue On Failure       Verify alarm generation for Past Comparison Detection alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Trend' 
				  Run Keyword And Continue On Failure      Verify alarm generation for dynamic threshold alarm        ${object}[${key}]
				  ${count}=       set variable     1
			END   
	END

*** Keywords ***

Verify alarm generation for threshold alarm
	[Arguments]    ${data}
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     ${data}[Alarm_name]
    Select the alarm type     ${data}[Alarm_Type]
    select the data source     ${data}[ENIQ_data_source]
    Select Single node or Collection or Subnetwork     ${data}[Single_node_or_collection_or_network]
	Select System area as	${data}[System_area]
	Select Node type as       ${data}[Node_type]
    Click on fetch nodes button
    Select Nodes as      ${data}[Node]
    Select Measure type as     ${data}[Measure_type_1],${data}[Measure_type_2],${data}[Measure_type_3]
    Select measures    ${data}[Measure_1],${data}[Measure_2],${data}[Measure_3]
    Select Alarm severity as      ${data}[Alarm_severity]
    Select Aggregation as      ${data}[Aggregation]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on scroll down button    5     10 
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button	
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
	[Teardown]    Test teardown steps for pmalarm
	
Verify threshold alarm generation for SubNetwork
	[Arguments]    ${data}
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     ${data}[Alarm_name]
    Select the alarm type     ${data}[Alarm_Type]
    select the data source     ${data}[ENIQ_data_source]
    Select Single node or Collection or Subnetwork     ${data}[Single_node_or_collection_or_network]
	Select System area for subnetwork as	${data}[System_area]
	Select Node type for subnetwork as       ${data}[Node_type]
    Select Subnetwork as      ${data}[Node]
    Select Measure type as     ${data}[Measure_type_1],${data}[Measure_type_2],${data}[Measure_type_3]
    Select measures    ${data}[Measure_1],${data}[Measure_2],${data}[Measure_3]
    Select Alarm severity as      ${data}[Alarm_severity]
    Select Aggregation as      ${data}[Aggregation]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on scroll down button    5     10 
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button	
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
	[Teardown]    Test teardown steps for pmalarm
	
Verify alarm generation for Past Comparison Detection alarm
	[Arguments]    ${data}
	open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     ${data}[Alarm_name]
    Select the alarm type     ${data}[Alarm_Type]
    select the data source     ${data}[ENIQ_data_source]
    Select Single node or Collection or Subnetwork     ${data}[Single_node_or_collection_or_network]
	Select System area as    ${data}[System_area]
	Select Node type as       ${data}[Node_type]
    Click on fetch nodes button
    Select Nodes as      ${data}[Node]
    Select Measure type as     ${data}[Measure_type_1],${data}[Measure_type_2],${data}[Measure_type_3]
    Select measures    ${data}[Measure_1],${data}[Measure_2],${data}[Measure_3]
    Select Alarm severity as      ${data}[Alarm_severity]
    Select Aggregation as      ${data}[Aggregation]
	Enter Look back period    ${data}[LookBack_Period_val]
	Select Look back period unit as    ${data}[LookBack_Period_unit]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on scroll down button    5     10 
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button	
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
	[Teardown]    Test teardown steps for pmalarm