*** Settings ***

Documentation     Verify That We Can Update PM Data After Editing Hour IDs For A Created Report
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

Verify That We Can Update PM Data After Editing Hour IDs For A Created Report
	[Tags]       PMEX_CDB    Report_Manager
	open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    NR
    Select Get Data For as    Node(s)
    click on scroll down button       6       30
    Select Aggregation    No Aggregation
    click on scroll up button       6       7
    Click on Refresh nodes button
    Select Nodes as      G2RBS01
    Select the measure type   COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    select Hour ID for Hour of Day filtering    0
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    HourID    Public    test
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    Public   test
    select the created report    ${report_name}
    Click on Edit button
    Verify that the Edit page is visible
    click on button    Measure Selection
    edit Hour ID for Hour of Day filtering    1
    click on scroll up button       1       2
    click on button    Fetch PM Data
    sleep    20
    click on button    Save Report
    Capture page screenshot