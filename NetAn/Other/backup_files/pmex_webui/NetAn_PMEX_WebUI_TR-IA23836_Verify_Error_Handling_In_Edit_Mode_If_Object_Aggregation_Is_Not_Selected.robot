*** Settings ***
Documentation     Verify Error Handling In Edit Mode If Object Aggregation Is Not Selected
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Verify Error Handling In Edit Mode If Object Aggregation Is Not Selected
    [Tags]        Report_Manager     PMEX
	open pm explorer analysis
	click on the scroll down button    0    20
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Click on scroll down button     6    20    
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    select a node
    Select measure type without Custom KPI    COUNTER
    Select the KPIs    SCTPOUTOFBLUES.DC_E_TCU_SCTP_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on button    Fetch PM Data
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Public    test
    Click on Save report to Library button
	select the created report    ${report_name}
	Click on Edit button
	sleep    20
	click on button    Update PM Data
	verify that KeyError notification pops up
	select object aggregation in edit page    No Aggregation
	click on button    Update PM Data
	Capture page screenshot
	