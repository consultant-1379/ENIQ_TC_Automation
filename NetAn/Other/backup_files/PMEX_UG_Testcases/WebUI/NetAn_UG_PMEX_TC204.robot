*** Settings ***
Documentation     Verify Edit Operation For Reports For Different System Area
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

Validate Report Creation For Multi Table From Different KPI's And Counters
    [Tags]     PMEX_CDB
	open pm explorer analysis
	Click on Report manager button
	Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)   
    Click on Refresh nodes button
    Select Nodes    G2RBS01
	Select the Aggregation as    No Aggregation
    Select the measure type    FLEX_PDF   
    Select KPIs    pmEbsDrbEstabAtt5qi.DC_E_NR_EVENTS_NRCELLCU_V_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	validate the page title    Report Manager
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
	Capture page screenshot
	
