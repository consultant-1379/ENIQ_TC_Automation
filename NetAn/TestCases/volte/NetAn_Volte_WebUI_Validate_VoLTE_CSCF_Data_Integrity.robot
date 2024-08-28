*** Settings ***

Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/VoLTEWebUI.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Suite setup       Set Screenshot Directory    ./Screenshots

*** Test Cases ***
	
Validate Volte CSCF data integrity
	open volte analysis
	click on Home button if not in volte home page
	Click on the scroll down button    0    25
	click on VoLTE Reset button	
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on    CSCF
	click on button value    Node Troubleshooting >>
	validate page title as    Node Troubleshooting
	Select the KPIs for CSCF
	Select the Worst Performing Nodes
	Verify that the Graph is visible
	Verify that the marked value is greater than 0
	click on button value    Daily Breakdown >>
	validate page title as    Daily Breakdown
	select days to compare    CSCF
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${measuredObject}    ${dateTime}    ${measureValue}=    recording the nodeName, measureName, measureObject, dateTime and measureValue
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/volte/VoLTE_dataIntegrity.json     CSCF
	${sqlQuery}=    replace values in the query    ${sqlQuery}    ${nodeName}    ${measureName}    ${measuredObject}    ${dateTime}
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser