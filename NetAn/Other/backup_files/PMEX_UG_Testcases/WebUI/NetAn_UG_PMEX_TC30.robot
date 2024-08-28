*** Settings ***
Documentation     Validate That LastModifiedOn Column Is Present In Report Manager Page
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

Validate That LastModifiedOn Column Is Present In Report Manager Page
    [Tags]      Report_Manager    PMEX_CDB           NetAn_UG_PMEX_TC30
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    click on scroll down button   6     20
    Select the Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes    ERBS1
    Select the measure type    COUNTER   
    Select KPIs    ACLENTRYPACKETS.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    click on button    Fetch PM Data
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	validate the page title    Report Manager
	verify that the column LastModifiedOn is present in Report Manager page
	Capture page screenshot
	