*** Settings ***
Documentation     Validate Editing A Report With A Pre-existing Name
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

Validate Editing A Report A Pre-existing Name Diff Case Sensitive
	[Tags]       PMEX_CDB          Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For as    Node(s)
    
    Click on Refresh nodes button
    Select Nodes    CCDM01
	Select the Aggregation as     No Aggregation
    Select the measure type    COUNTER   
    Select KPIs    ERIC-ACT-MAPI-REQUESTS-RECV.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    click on button    Fetch PM Data
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	validate the page title    Report Manager
	Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)   
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
	${report_name1}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	validate the page title    Report Manager
	select the created report    ${report_name1}
	Click on Edit button
	sleep    20
	click on the button    Show Selection Panel
	edit the Aggregation    No Aggregation
	click on the button    Data Integrity Check
	click on button    Save Report
	validate the page title    Save Report
	${upper_case_report_name} =    Convert To Uppercase  ${report_name}
	enter the report name    ${upper_case_report_name}
	click on button      Save Report to Library
	verify that a report with entered name already exists
	click the OK button
	Capture page screenshot
