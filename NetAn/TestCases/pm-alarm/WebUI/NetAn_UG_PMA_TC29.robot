*** Settings ***

Documentation     EQEV-108162 - Verify That If The Collection Is Used In An Alarm And We Try To Delete It The Delete Collection button Will Notify
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

Verify That If The Collection Is Used And We Try To Delete It The Delete Collection button Will Notify
	[Tags]    PMA_KGB    NetAn_UG_PMA_TC29    EQEV-108162
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_Delete_Used_Collection.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    	IF      '${object}[${key}][Alarm_Type]'=='Threshold'
				   Run keyword and continue on failure      Verify alarm generation for threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection + Continuous Detection'
				   Run keyword and continue on failure        Verify alarm generation for pcd_cd alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Case Dependent Threshold'
				   Run keyword and continue on failure       Verify alarm generation for case dependent threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Dynamic Threshold'
				   Run keyword and continue on failure       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Continuous Detection'
				   Run keyword and continue on failure       Verify alarm generation for dynamic threshold alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Past Comparison Detection'
				   Run keyword and continue on failure       Verify alarm generation for Past Comparison Detection alarm       ${object}[${key}]
				   ${count}=       set variable     1
			ELSE IF        '${object}[${key}][Alarm_Type]'=='Trend' 
				  Run keyword and continue on failure      Verify alarm generation for dynamic threshold alarm        ${object}[${key}]
				  ${count}=       set variable     1
			END   
    END
	
*** Keywords ***

Verify alarm generation for threshold alarm
    [Arguments]    ${data}
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         ${data}[Collection_name]
    Select ENIQ Data Source in collection manager        ${data}[ENIQ_data_source]
    Select System area for collection manager        ${data}[System_area]
    Select Node type for collection manager             ${data}[Node_type]
    Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       ${data}[Node]
    Click on Create button
	validate the page title    Node Collection Manager
	select the created collection and click on delete    ${collection}
	close the delete collection prompt using Cancel button
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         ${data}[Alarm_name]
    Select the alarm type     ${data}[Alarm_Type]
    select the data source     ${data}[ENIQ_data_source]
    Select Single node or Collection or Subnetwork     ${data}[Single_node_or_collection]
    Select Collection name as    ${collection}
    Select Measure type as     ${data}[Measure_type]
    Select measures    ${data}[Measure_1]
	Select Alarm severity as      ${data}[Alarm_severity]
    Select Aggregation as      ${data}[Aggregation]
    Select Probable cause as       ${data}[Probable_cause]
    Enter specific problem     ${data}[Specific_problem]    ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button
    Click on the Node Collection manager button
	select the created collection and click on delete    ${collection}
	close the delete collection prompt using OK button
    
	select the created collection and click on delete    ${collection}
    Verify when collection is used delete verification message is visible
	[Teardown]    Test teardown steps for pmalarm