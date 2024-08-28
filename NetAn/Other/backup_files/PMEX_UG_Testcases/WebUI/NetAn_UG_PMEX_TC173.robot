*** Settings ***
Documentation     Check if the flex-filter values are added non flex counter in flex-filter values column in 'Measure mapping (selected)' table
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

*** Test Cases ***

Check if the flex-filter values are added non flex counter in flex-filter values column in 'Measure mapping (selected)' table
    [Tags]      PMEX_CDB    Report_Manager
    Open PM Explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as    ERBS1
    Select Aggregation    No Aggregation
    Select the measure type    COUNTER,ERICSSON_KPI
    Select KPIs    Added E-RAB Establishment Success Rate
    Verify that Fetch and Add Flex filter buttons are not visible
    Capture page screenshot
    

