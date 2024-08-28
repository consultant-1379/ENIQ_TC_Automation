*** Settings ***

Documentation     Verify That A Report Created With Hour ID And Data Integrity Check Box Checked Can Be Edited
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

Verify That A Report Created With Hour ID And Data Integrity Check Box Checked Can Be Edited
	[Tags]       PMEX_CDB     PMEX_Custom_KGB     Report_Manager       NetAn_UG_PMEX_TC99
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as        G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    select Hour ID for Hour of Day filtering    0
    Check the Data Integrity Check box and Fetch PM Data
    Click Save report button
    ${report_name}=    Enter details to save report to library    HourID    Public    test
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    Public   test
    select the created report    ${report_name}
    Click on Edit button
    Verify that the Edit page is visible
    click on the scroll down button    7    25
    edit Hour ID for Hour of Day filtering    1
    click on button    Update PM Data
    click on Save Report button
    Click on Save report to Library button
    Capture page screenshot