*** Settings ***
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

Validate That 'Hour IDs' Is Added To EDIT Page
    [Tags]  Report_Manager      PMEX
	open pm explorer analysis
	
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    select a node
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    select Hour ID for Hour of Day filtering    0
    click on button    Fetch PM Data
    Click Save report button
    ${report_name}=    Enter details to save report to library    HourID    Public    test
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    Public   test
    select the created report    ${report_name}
    Click on Edit button
    Verify that the Edit page is visible
    click on the scroll down button    7    25
    verify that Hour of Day filtering is present in Edit page
    Capture page screenshot
	
	
 