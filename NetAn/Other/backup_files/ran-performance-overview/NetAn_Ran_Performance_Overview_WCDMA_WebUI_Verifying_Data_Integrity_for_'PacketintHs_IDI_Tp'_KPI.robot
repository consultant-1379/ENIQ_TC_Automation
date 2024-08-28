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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/RanPerformanceOverviewWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verify Data Integrity for 'PacketintHs_IDI_Tp' KPI
	open ran performance wcdma overview analysis
	click on the scroll down button    0    25
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	navigate to the section    Quality of Service
	click on button    Quality of Service
	verify the page title    Quality of Service
	click on QoS KPI Details button
	verify the page title    Quality of Service: Details
	select a QoS KPI    Cell throughput (PacketintHs_IDl_Tp)
	${dateTime}=    read the date and time
	${node}    ${measure}=    read the nodeName and measureValue from current week chart
	${node1}    ${measure1}=    read the nodeName and measureValue from past week chart
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ran-performance-overview/RPO_dataIntegrity.json     PacketintHs_IDl_Tp_Today
	${sqlQuery}=    replace values in the query    ${sqlQuery}    ${dateTime}    ${node}
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	Match UI with DB RPO Value    ${measure}     ${DB_Value}
	${sql_query1}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ran-performance-overview/RPO_dataIntegrity.json     PacketintHs_IDl_Tp_PastWeek
	${sqlQuery1}=    replace values in the query    ${sqlQuery1}    ${dateTime}    ${node1}
	${DB_Value1}=    Query Sybase database    ${sqlQuery1}
	Match UI with DB RPO Value    ${measure1}     ${DB_Value1}
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	