*** Settings ***
Documentation      Check Report Generation With All 'Day Of Week' Check Boxes Unchecked
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

Check Report Generation With All 'Day Of Week' Check Boxes Unchecked
    [Tags]      PMEX_CDB    Report_Manager      NetAn_UG_PMEX_TC86
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as    G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    uncheck Days in Advanced Options    MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY
    click on button    Fetch PM Data
    verify that error message is visible
    Capture page screenshot
   
 