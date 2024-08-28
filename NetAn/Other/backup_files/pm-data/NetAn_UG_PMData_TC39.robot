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
    [Tags]    PMD_CDB
    open counter mapping table in pm-data
    ${selectedRows}=    filter the counter values with    WMG
    ${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-data/WMG_SQL.json     WMG
    verify that the same count is present in ENIQ DB    ${selectedRows}     ${sql_query}
	[Teardown]    close browser