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

Verify That Active and Inactive Nodes are Present In The Analysis
	[Tags]     Energy_Report_CDB
	${dbResult1}=    Query the eniq database and fetch an inactive node		
    ${dbResult2}=    Query the eniq database and fetch an active node	
	Click on Reset All Filters and Markings button
	click on button value    Energy Usage
	verify the page title   Energy Usage (7 Days)
	select a RAT
	verify node name present in list   ${dbResult1}
	verify node name present in list   ${dbResult2}