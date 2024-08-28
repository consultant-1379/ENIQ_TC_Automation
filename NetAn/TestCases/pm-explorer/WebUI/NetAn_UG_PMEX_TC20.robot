*** Settings ***
Documentation     Validate Editing A Report With A Different Name
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

Validate Editing A Report A Different Name
    [Tags]       PMEX_CDB         Report_Manager      NetAn_UG_PMEX_TC20
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For as   Node(s)
    
    Click on Refresh nodes button
    Select Nodes    ERBS1
	Select the Aggregation as    No Aggregation
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
	select the created report    ${report_name}
	Click on Edit button
	sleep    20
	click on button    Save Report
	validate the page title    Save Report
	${report_name}=    Enter details to save report to library    EDITReport_    Public    test
	Click on Save report to Library button
	Capture page screenshot
