*** Settings ***
Documentation     Verify Data Integrity for 'Speech_A' KPI
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

Verify Data Integrity for 'Speech_A' KPI
    [Tags]       WCDMA_CDB
	open wcdma overview analysis
	Mouse scroller
	click on the scroll down button    0    25
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	navigate to the section    Quality of Service
	click on button    Mobility and Accessibility
	verify the page title    Mobility and Accessibility
	click on Mobility and Accessibility KPI Details
	verify the page title    Mobility and Accessibility: Details
	select a Mobility and Accessibility KPI    Speech accessibility (Speech_A)
	${dateTime}=    read the date and time
	${node}    ${measure}=    read the nodeName and measureValue from current week Mobility and Accessibility chart
	${node1}    ${measure1}=    read the nodeName and measureValue from last week chart
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ran-performance-overview/RPO_dataIntegrity.json     SPEECH_A_Today
	${sqlQuery}=    replace values in the query    ${sqlQuery}    ${dateTime}    ${node}
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	Match UI with DB RPO Value    ${measure}     ${DB_Value}
	${sql_query1}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ran-performance-overview/RPO_dataIntegrity.json     SPEECH_A_PastWeek
	${sqlQuery1}=    replace values in the query    ${sqlQuery1}    ${dateTime}    ${node1}
	${DB_Value1}=    Query Sybase database    ${sqlQuery1}
	Match UI with DB RPO Value    ${measure1}     ${DB_Value1}
	Capture page screenshot
	