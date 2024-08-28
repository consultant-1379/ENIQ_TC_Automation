*** Settings ***
Documentation     Validate if report is created successfully
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

Validate if report is created successfully
    [Tags]     PMEX_CDB         Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Verify if all fields are empty when opening measure selection page
    Verify if all fields are empty message is displayed
    Verify if all fields without selecting data source
    Select ENIQ DataSource    NetAn_ODBC
    Verify if node type is present for all system areas
    Select System area and verify the contents    Radio
    Select Node type    NR    
    Verify if all fields are empty when the value of System Area dropdown is changed    Radio    Core
    Select Get Data For and verify the contents    SubNetwork
    Click on scroll down button     6    20
    Select multiple subnetwork    G2RBS01    G2RBS04
    Verify if aggregation dropdown will is restricted when object aggregation is not selected
    Select Aggregation and verify the contents    No Aggregation
    Select the measure type    COUNTER
    Select KPIs and verify fetch pm data button    sctpOutOfBlues.DC_E_TCU_SCTP_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Public    test
    Click on Save report to Library button
    select the created report    ${report_name}
    validate the page title    Report Manager
    Capture page screenshot