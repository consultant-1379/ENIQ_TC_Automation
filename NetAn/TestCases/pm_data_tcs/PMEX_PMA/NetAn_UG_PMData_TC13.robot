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
	[Tags]    PMD_CDB      EQEV-131255       NetAn_UG_PMData_TC13
    ${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/cNELS_PMEx_Counters.json    #replace POC.json with the JSON file created using Data_Set_Generator_For_PMEX#
    &{object}=    Evaluate     json.loads('''${json}''')     json
    ${count}=       set variable     0
	open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    NetAn_ODBC
	Select System area as    Core
    Select Node type as    cNELS
	Select the measure type   COUNTER
    FOR   ${key}   IN  @{object.keys()}
    	Run Keyword And Continue On Failure    Verify That The New Measure Is Present In PMEx       ${object}[${key}]
    END
    
*** keywords ***

Verify That The New Measure Is Present In PMEx
    [Arguments]      ${data}	
    verify that the measure is present in PMEx       ${data}[Measure]
	[Teardown]    capture page screenshot