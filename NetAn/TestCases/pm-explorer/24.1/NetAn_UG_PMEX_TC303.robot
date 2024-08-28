*** Settings ***
Documentation     Verify the row count in all the report pages in PMEx
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

*** Test Cases ***

Create A Report Which Has More Than One Page In It And Verify the row count in all the report pages
	[Tags]     PMEX_CDB     EQEV-131195
	open pm explorer analysis
	click on the scroll down button    0    20
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    ERICSSON_KPI,PDF_COUNTER
    Select KPIs     CBRA Success Rate,pmMacVolDlDrbQos.DC_E_NR_NRCELLDU_V_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     ROP
    Fill the row count       10
    Click on fetch pmdata button
    Switch report page     pm_DC_E_NR_NRCELLDU_V_RAW(No Aggregation Level)__NetAn_ODBC
    Verify the row counts to be same as given in measure selection page       10
    Click Save report button
    ${report_name}=    Enter details to save report to library    Report    Public    test
    Click on Save report to Library button
	Capture page screenshot

