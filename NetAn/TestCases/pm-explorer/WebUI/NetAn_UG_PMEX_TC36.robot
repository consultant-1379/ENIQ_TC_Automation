*** Settings ***
Documentation     Verify That ModifiedBy Column Is Empty For Newly Created Reports
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verify That ModifiedBy Column Is Empty For Newly Created Reports
    [Tags]      Report_Manager      PMEX_CDB       NetAn_UG_PMEX_TC36
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
	Click on Refresh nodes button
    select Nodes    ERBS1
    Select the Aggregation    No Aggregation   
    Select the measure type    COUNTER   
    Select KPIs    ACLENTRYPACKETS.DC_E_TCU_ACLENTRYIP4_RAW
    select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	validate the page title    Report Manager
	verify that the ModifiedBy column is empty    ${report_name}
	Capture page screenshot
	