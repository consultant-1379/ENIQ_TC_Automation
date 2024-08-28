*** Settings ***
Documentation     Verify The Edit Report Functionality For A Report Of Other Node Types Than NR Or ERBS On Newly Opened Analysis
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

*** Test Cases ***

Verify The Edit Report Functionality For A Report Of Other Node Types Than NR Or ERBS On Newly Opened Analysis
    [Tags]      PMEX_CDB    Report_Manager 
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    Pico_LTE
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as    ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    ifHCInBroadcastPkts.DC_E_PRBS_CPP_ETHERNETPORT_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    click on button    Fetch PM Data
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Public    test
    Click on Save report to Library button
    select the created report    ${report_name}
    Click on Edit button
    Check the Show Selection Panel checkbox
    click on button    Update PM Data
    click on button    Save Report
    Capture page screenshot
	