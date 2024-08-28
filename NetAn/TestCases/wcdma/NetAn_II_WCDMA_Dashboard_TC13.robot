*** Settings ***
Documentation     Verify Data Integrity for 'Speech_U_User' KPI
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Library           pyodbc
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${WCDMAKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot

*** Test Cases ***

Verify Data Integrity for 'Speech_U_User' KPI
    [Tags]       WCDMA_KGB
	open wcdma overview analysis
	Mouse scroller
	click on the scroll down button    0    25
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	navigate to the section    Quality of Service
	click on button    Utilization
	verify the page title    Utilization
	click on button    Utilization KPI Details
	verify the page title    Utilization: Details
	select a Utilization KPI    Speech erlang (Speech_U_User)
	${dateTime}=    read the date and time
	${node}    ${measure}=    read the nodeName and measureValue from current week Utilization chart
	${node1}    ${measure1}=    read the nodeName and measureValue from last week chart
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ran-performance-overview/RPO_dataIntegrity.json     Speech_Erlang_Today
	${sqlQuery}=    replace values in the query    ${sqlQuery}    ${dateTime}    ${node}
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	Match UI with DB RPO Value    ${measure}     ${DB_Value}
	${sql_query1}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ran-performance-overview/RPO_dataIntegrity.json     Speech_Erlang_PastWeek
	${sqlQuery1}=    replace values in the query    ${sqlQuery1}    ${dateTime}    ${node1}
	${DB_Value1}=    Query Sybase database    ${sqlQuery1}
	Match UI with DB RPO Value    ${measure1}     ${DB_Value1}
	Capture page screenshot
	
 	