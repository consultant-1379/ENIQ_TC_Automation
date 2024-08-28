*** Settings ***

Documentation     Verify All Counters From Latest TP Are Present In Counter Mapping Table
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify All Counters From Latest TP Are Present In Counter Mapping Table
    [Tags]    PMD_CDB             NetAn_UG_PMData_TC10
	${json}=    OperatingSystem.get file    ./ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/24.1_Iteration_Counter_Mapping.json    
    &{object}=    Evaluate     json.loads('''${json}''')     json
    open counter mapping table in pm-data
	FOR   ${key}   IN  @{object.keys()}    
    	Run Keyword And Continue On Failure    Verify Counters From Latest TP Are Present In Counter Mapping Table      ${key}          ${object}[${key}]
    END

	
	
*** Keywords ***

Verify Counters From Latest TP Are Present In Counter Mapping Table
    [Arguments]      ${node_type}       ${sql}
	${selectedRows}=    filter the counter values with    ${node_type}
    #${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/MTAS_SQL.json     ${sql}
    verify that the same count is present in ENIQ DB    ${selectedRows}     ${sql}
