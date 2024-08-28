*** Settings ***

Documentation     Verify That The KPI Formula Is Written Properly
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library			  DatabaseLibrary
Library			  Process
Library			  CSVLibrary
Library           SSHLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify That The KPI Formula Is Written Properly for KPI - Network Initiated Service Request Failure Ratio
    [Tags]    PMD_CDB            NetAn_UG_PMData_TC09
    ${data}=    get data from CSV file for the KPI    Measures24.1.csv    Network Initiated Service Request Failure Ratio
    ${formula}    ${table}=    get KPI formula and Table Information from CSV file    ${data}
    verify that the columns used in KPI formula are present in Counters column and in DB    ${formula}    ${table}
	[Teardown]    close browser