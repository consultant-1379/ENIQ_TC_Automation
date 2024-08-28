*** Settings ***

Documentation     Verify That The Days Selected In 'Day Of Week' Filtering Are Checked In The Edit Page
Library           DatabaseLibrary
Library           AutoItLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify That The Days Selected In 'Day Of Week' Filtering Are Checked In The Edit Page
	[Tags]       PMEX_CDB     Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as     G2RBS01
    Select the Aggregation    No Aggregation
    click on scroll up button       6       7
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    select Day in Advanced Options    MONDAY
    click on button    Fetch PM Data
    Click Save report button
    ${report_name}=    Enter details to save report to library    HourID    Public    test
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    Public   test
    select the created report    ${report_name}
    Click on Edit button
    Verify that the Edit page is visible
    click on button    Measure Selection
    click on the scroll down button    7    17
    verify that only the day selected during report creation is checked
    Capture page screenshot