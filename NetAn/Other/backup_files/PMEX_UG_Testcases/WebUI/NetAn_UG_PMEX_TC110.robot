*** Settings ***
Documentation     Testing Core Nodetypes
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Verify The AccessType Colomn In netAnServer_pmdb
    [Tags]     Collection_Manager    PMEX_CDB
	open pm explorer analysis
	${result}=    Query Postgre database and return output    select "AccessType" from "tblCollection"
	Log    ${result}
	${length}=    get length    ${result}
	Log    ${length}
	should not be equal    ${length}    0
	