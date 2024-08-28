*** Settings ***
Library           Edit Hour_IDs For A Created Report In The Edit Page
Library           AutoItLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}


*** Test Cases ***

Edit Hour IDs For A Created Report In The Edit Page
    [TAGS]    PMEX_CDB      Report_Manager          NetAn_UG_PMEX_TC87
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
										   
    Click on Refresh nodes button
    Select Nodes as         G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    select Hour ID for Hour of Day filtering    0
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    HourID    Public    test
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Close Browser
    Open pm explorer analysis with another user
    Click on Report manager button
    select the created report    ${report_name}
    Click on Edit button
    Sleep     10s
    Verify that the Edit page is visible
    click on the scroll down button    7    25
    edit Hour ID for Hour of Day filtering    1
    Click on update pmdata button
    Click Save report button
    Verify that the dropdown is disabled in Save report
    Capture page screenshot
