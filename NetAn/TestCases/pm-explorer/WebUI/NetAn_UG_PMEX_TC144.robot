*** Settings ***
Documentation     Report Creation with Get Data for-Nodes, Object Aggregation-All selected, Node Type-Core and Calendar Interval
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

Report Creation with Get Data for-Nodes, Object Aggregation-All selected, Node Type-Core and Calendar Interval
    [Tags]      PMEX_CDB    Report_Manager 
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select the Aggregation    All Selected
    Select the measure type    COUNTER   
    Select KPIs    ERIC-ACT-MAPI-REQUESTS-RECV.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Calendar Interval
    Enter the Calendar Interval    01/09/2022    09/09/2022 
    Click on scroll up button    7    20
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    All Selected      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}

 