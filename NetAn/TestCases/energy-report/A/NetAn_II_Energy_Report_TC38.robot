*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


*** Test Cases ***

Verify The Node Status In ENIQ Server And Fetch A Node
    [Tags]     Energy_Report_CDB
	${dbResult1}=    Query the eniq database and fetch an inactive node
	${dbResult2}=    Query the eniq database and fetch an active node
	verify active and inactive nodes do not match    ${dbResult1}    ${dbResult2}