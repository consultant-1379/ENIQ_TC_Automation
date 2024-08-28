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
	[Tags]    PMD_CDB       EQEV-131255       NetAn_UG_PMData_TC12  
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/cNELS_PMA_Counters.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMA.robot#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
	open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm
    Select alarm type as     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
	Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Core
    Select Node type as       cNELS
    
	select measure type     COUNTER
    FOR   ${key}   IN  @{object.keys()}
    	Run Keyword And Continue On Failure     Verify That The New Measure Is Present In PMA       ${object}[${key}]
    END

*** Keywords ***
    
Verify That The New Measure Is Present In PMA
    [Arguments]      ${data}    
    Select measures     ${data}[Measure]
	[Teardown]      Capture page screenshot