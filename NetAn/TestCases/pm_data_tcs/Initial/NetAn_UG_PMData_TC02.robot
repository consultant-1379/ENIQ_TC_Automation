*** Settings ***

Documentation     Verify That The New Measure for 24.1 iteration 1 Is Present In PMEx
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
Suite setup       Suite setup steps for WebUI
Suite teardown    Suite teardown steps for WebUI
#Test setup        Navigate to PMEX home page
Test teardown      Test teardown steps for webUI

*** Test Cases ***

Verify That The New KPIs for 24.1 iteration 1 Is Present In PMEx
	[Tags]    PMD_CDB               NetAn_UG_PMData_TC02
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/24.1_Iteration_1_PMEx_KPI.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMEX#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
	open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    NetAn_ODBC
    FOR   ${key}   IN  @{object.keys()}
    	Run Keyword And Continue On Failure    Verify That The New Measure Is Present In PMEx       ${object}[${key}]
    END
    
*** keywords ***

Verify That The New Measure Is Present In PMEx
    [Arguments]      ${data}    
    Select System area as    ${data}[System_area]
    Select Node type as    ${data}[Node_type]
    Select Get Data For as    ${data}[Get_Data_for]
    Select the measure type   ${data}[Measure_type]
    verify that the measure is present in PMEx       ${data}[Measure]
	[Teardown]    capture page screenshot