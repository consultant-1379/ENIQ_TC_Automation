*** Settings ***
Documentation     Validate Date field while Editing A Report
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Date Column value while Editing A Report
    [Tags]       PMEX_CDB	  Report_Manager
	open pm explorer analysis
    Click on scroll down button    0    20
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    ERBS
    Select Get Data For    Node(s)   
    Click on Refresh nodes button
    Select Nodes    ERBSG201
	Select the Aggregation as    No Aggregation
    Select the measure type    COUNTER   
    Select the KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	validate the page title    Report Manager
	select the created report    ${report_name}
	Click on Edit button
	sleep    20
    Verify the date column value
	Capture page screenshot


