*** Settings ***
Documentation     Validate data integrity check box in create edit and view mode
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

Validate data integrity check box in create edit and view mode
    [Tags]     PMEX_CDB          Report_Manager
    open pm explorer analysis	
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select multiple nodes    G2RBS01    G2RBS04
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    sctpOutOfBlues.DC_E_TCU_SCTP_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on data integrity check box
    Click on fetch pmdata button
    Verify if file availability column in added after checking data integrity check box on create page
    Click Save report button
    ${report_name}=    Enter details to save report to library    $TR-Report$    Public    test
    Click on Save report to Library button
    select the created report    ${report_name}
    Click on Edit button
    click on Save Report button
    Verify if all fields are same while saving in edit mode    ${report_name}    Public    test
    Click on scroll down button     5    3
    Click on cancel button in save report page
    Check the Show Selection Panel checkbox
    sleep    20
    Verify if file availability column in added after checking data integrity check box on edit and view page
    Click on data integrity check box
    Click on update pmdata button
    sleep    30
    Verify if file availability column in removed after unchecking data integrity check box
    Close the Edit page
    validate the page title    Report Manager
    Click on View button
    Check the Show Selection Panel checkbox
    sleep    20
    Verify if file availability column in added after checking data integrity check box on edit and view page
    Click on data integrity check box
    Click on update pmdata button
    sleep    30
    Verify if file availability column in removed after unchecking data integrity check box
    Close the View Report page
    validate the page title    Report Manager
    Capture page screenshot
	