*** Settings ***

Documentation     Verify Alarm Generation And Data Integrity For Counters
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

Verify Alarm Generation And Data Integrity For Counters
	[Tags]    PMA         NetAn_UG_PMA_TC23
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_WebUIKPIs.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	  		IF      '${object}[${key}][Alarm_Type]'=='Threshold'  
				   Run Keyword And Continue On Failure       Verify alarm generation for threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection + Continuous Detection'
				   Run Keyword And Continue On Failure        Verify alarm generation for pcd_cd alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Case Dependent Threshold'
				   Run Keyword And Continue On Failure       Verify alarm generation for threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Dynamic Threshold'
				   Run Keyword And Continue On Failure       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Continuous Detection'
				   Run Keyword And Continue On Failure       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection'
				   Run Keyword And Continue On Failure       Verify alarm generation for Past Comparison Detection alarm       ${object}[${key}]
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Trend' 
				  Run Keyword And Continue On Failure      Verify alarm generation for dynamic threshold alarm        ${object}[${key}]
			END   
		
    END    
    
*** Keywords ***           
    
Verify alarm generation for threshold alarm
    [Arguments]      ${data}
	open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     ${data}[Alarm_name]
    Select the alarm type     ${data}[Alarm_Type]
    select the data source     ${data}[ENIQ_data_source]
    Select Single node or Collection or Subnetwork     ${data}[Single_node_or_collection_or_network]
    select system area as      ${data}[System_area]
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
    Click on scroll down button    5     10 
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    Verify columns displayed    ${data}[Columns_diplayed]
	Verify data integrity of the measures      ${data}[Measure]     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4]    
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button	
	[Teardown]    Test teardown steps for pmalarm