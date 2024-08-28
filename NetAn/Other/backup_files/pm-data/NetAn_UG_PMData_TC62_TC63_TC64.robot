*** Settings ***

Documentation     Verify That The New Measure Is Present In PMEx
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py

*** Test Cases ***

Verify That The New Measure Is Present In PMEx
    [Tags]       PMD_CDB
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/EPG_PMEX.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
    	add test case    ${key}     Verify That The New Measure Is Present In PMEx       ${object}[${key}]
    END
    
*** keywords ***

Verify That The New Measure Is Present In PMEx
    [Arguments]      ${data}
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    ${data}[Data_source]
    Select System area as    ${data}[System_area]
    Select Node type as    ${data}[Node_type]
    Select the measure type   ${data}[Measure_type]
    verify that the measure is present in PMEx       ${data}[Measure]
	[Teardown]    close browser