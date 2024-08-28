*** Settings ***
Documentation     Verify Report Creation with Selecting 'Existing Interval Definition' with Month Aggregation In Select Time Panel in webui
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verify Report Creation with Selecting 'Existing Interval Definition' with Month Aggregation In Select Time Panel in webui
    [Tags]     PMEX_CDB          Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select Aggregation    No Aggregation
    Select the measure type   COUNTER
    Select KPIs        eric-act-notification-nudr-prov-successful-responses-recv.DC_E_CCDM_ACT_NOTIF_NUDR_PROV_RAW
    Select time drop down to      Define Interval
    Select Aggregation in select time as    Month
	${intervalName}=    Create an Interval    Interval5    30/09/2022    06/11/2022
	Select time drop down to      Existing Interval Definitions
	select an interval    ${intervalName}
	Click on fetch pmdata button
	Verify the page title    No Aggregation      NetAn_ODBC     MONTH
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
