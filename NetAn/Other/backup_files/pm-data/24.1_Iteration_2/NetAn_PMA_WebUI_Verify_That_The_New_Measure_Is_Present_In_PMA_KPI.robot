*** Settings ***

Documentation     Verify That The New Measure Is Present In PMA
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py

*** Test Cases ***

Verify That The New Measure Is Present In PMA
	[Tags]    PMD_CDB
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/24.1_PMA_KPI.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMA.robot#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
    	Run Keyword And Continue On Failure     Verify That The New Measure Is Present In PMA       ${object}[${key}]
    END

*** Keywords ***
    
Verify That The New Measure Is Present In PMA
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
    #Click on fetch nodes button
    #Select Nodes as      ${data}[Node]
    select measure type     ${data}[Measure_type]
    verify that the measure is present in PMA    ${data}[Measure]
	[Teardown]    close browser