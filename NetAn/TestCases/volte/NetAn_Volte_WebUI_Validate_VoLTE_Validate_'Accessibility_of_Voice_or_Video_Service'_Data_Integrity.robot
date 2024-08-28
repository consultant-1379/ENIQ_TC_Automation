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

***Test Cases***

Test Case: Volte Validate Accessibility of Voice/Video Service data integrity
	open volte analysis
	click on Home button if not in volte home page
	Click on the scroll down button    0    25
	click on VoLTE Reset button	
	click on button title    VoLTE Monitor
	validate page title as    VoLTE Monitor
	click on tab    Accessibility of Voice/Video Service
	click on button value    Node Troubleshooting
	validate page title as    Node Troubleshooting
	Select the KPIs
	Select the Worst Performing Nodes
	Verify that the Graph is visible
	Verify that the marked value is greater than 0
	click on button value    Daily Breakdown >>
	validate page title as    Daily Breakdown
	select Days to compare from Daily Breakdown page
	click on button value    Filtered Data >>
	Enable the columns    MEASURED_OBJECT    NodeName
	${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}    ${measureValue}=    recording nodeName, measureName, cellFDN, dateTime and measureValue
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/volte/VoLTE_dataIntegrity.json     ERBS
	${sqlQuery}=    Replace The Values In The Query    ${sql_query}    ${nodeName}    ${measureName}    ${cellFDN}    ${dateTime}
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	Match UI with DB VoLTE Value    ${measureValue}     ${DB_Value}
	Capture page screenshot
    [Teardown]    Close Browser
