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
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/24.2_Iteration_1_PMA_Counters.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMA.robot#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
	open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm
    Select alarm type as     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    FOR   ${key}   IN  @{object.keys()}
    	Run Keyword And Continue On Failure     Verify That The New Measure Is Present In PMA       ${object}[${key}]
    END

*** Keywords ***
    
Verify That The New Measure Is Present In PMA
    [Arguments]      ${data}
	Click on scroll up button    5   30
    Select System area as      ${data}[System_area]
    Select Node type as       ${data}[Node_type]
    select measure type     ${data}[Measure_type]
    Select measures    ${data}[Measure]
	[Teardown]     capture page screenshot