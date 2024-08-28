*** Settings ***
Documentation     Validate update all check box in edit and view mode
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

Validate update all check box in edit and view mode
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
    Select Nodes    G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    CUSTOM_KPI
    Select KPIs    EnhancedFlex1_KPI
    Select KPIs    EnhancedFlex2_KPI
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Private    test
    Click on Save report to Library button
    select the created report    ${report_name}
    Click on Edit button
    click on Save Report button
    Verify if all fields are same while saving in edit mode    ${report_name}    Private    test
    Click on scroll down button     5    3
    Click on cancel button in save report page
    Check the Show Selection Panel checkbox
    sleep    20
    Select Aggregation in select time as    Month
    Click on update all pages check box
    Click on update pmdata button
    sleep    30
    Verify if all files are getting update when click on update all pages check box    ${report_name}    MONTH
    Close the Edit page
    validate the page title    Report Manager
    Click on View button
    Check the Show Selection Panel checkbox
    sleep    20
    Select Aggregation in select time as    Week
    Click on update all pages check box
    Click on update pmdata button
    sleep    30
    Verify if all files are getting update when click on update all pages check box    ${report_name}    WEEK
    Close the View Report page
    validate the page title    Report Manager
    Capture page screenshot
	
	