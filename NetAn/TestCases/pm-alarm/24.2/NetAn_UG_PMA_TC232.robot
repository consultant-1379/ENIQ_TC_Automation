*** Settings ***

Documentation     Verify Alarm creation in PMA for cNELS Counters
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

Verify Alarm creation in PMA for cNELS Counters
	[Tags]    PMA_CDB      EQEV-131255       NetAn_UG_PMA_TC232
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/cNELS_PMA_DataIntergerity.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	FOR   ${key}   IN  @{object.keys()}
	    Run keyword and continue on failure      Verify alarm generation for threshold alarm       ${object}[${key}]				   
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
    Select System area as      ${data}[System_area]
    Select Node type as    ${data}[Node_type] 
    Click on fetch nodes button in Alarm rules manager
    Select Nodes as    ${data}[Node]         
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
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button	
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
	[Teardown]    Test teardown steps for pmalarm