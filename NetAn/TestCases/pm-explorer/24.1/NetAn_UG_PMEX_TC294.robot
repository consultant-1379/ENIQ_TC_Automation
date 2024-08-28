*** Settings ***
Documentation       Validate Report Generation For Custom KPI For Simple Flex Counter
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot



*** Test Cases ***

Validate Report Generation For Custom KPI With Simple Flex Counter
    [Tags]      TR-IA67930    PMEX_CDB
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    CUSTOM_KPI
    Select KPIs        Flex_customkpi
    Select KPIs        Pdf_customkpi
    Select time drop down to      Last 30 Days    
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    Capture page screenshot
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click Save report button
    ${report_name}=    Enter details to save report to library    Custom_KPI    Public   NA
    Click on Save report to Library button
    select the created report    ${report_name}
    Click on Edit button
    Check the Show Selection Panel checkbox
    sleep    20
    Select Aggregation in select time as    Month
    Click on update all pages check box
    Click on update pmdata button
    sleep    30
    Verify if all pages are updated when click on update all pages check box    ${report_name}    MONTH
    Close the Edit page
    validate the page title    Report Manager
    Capture page screenshot
    

 