*** Settings ***

Documentation     Update PM Data After Editing Selected Days In 'Day Of Week' Filtering
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

Update PM Data After Editing Selected Days In 'Day Of Week' Filtering
    [TAGS]    PMEX_CDB       Report_Manager          NetAn_UG_PMEX_TC88
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as      G2RBS01
    Click on scroll down button    6    20   
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Hour
    select Day in Advanced Options    MONDAY
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    HourID    Public    test
    Click on Save report to Library button
    Verify saved report available in Report manager GUI     ${report_name}    Public   test
    select the created report    ${report_name}
    Click on Edit button
    click on Measure Selection button
    select Day in Advanced Options in edit page   MONDAY,TUESDAY,FRIDAY
    Click on fetch pmdata button
    Capture page screenshot