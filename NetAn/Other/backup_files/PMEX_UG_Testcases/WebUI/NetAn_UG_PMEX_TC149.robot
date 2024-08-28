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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Report Creation with Selecting 'Calender Interval' In Select Time Panel
    [Tags]      PMEX_CDB      Report_Manager
    open pm explorer analysis
    Click on scroll down button    0    20
									
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Click on scroll down button    6    20
    Select Node type    CCDM
    Select Get Data For    Node(s)
	Click on Refresh nodes button
    Select Nodes    CCDM01
    Select Aggregation    No Aggregation
    
    Select the measure type   COUNTER
    Select the KPIs        eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Calendar Interval
    Sleep           10
    Select Aggregation in select time as    Month
	Enter the Calendar Interval           01/11/2022    08/12/2022
	Click on fetch pmdata button
	Sleep           20
	Verify the page title    No Aggregation      NetAn_ODBC     Month
										