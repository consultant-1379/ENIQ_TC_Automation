*** Settings ***
Documentation     Validate_Update_Of_ObjectAggregation_And_DataIntegrity_In_Edit_Mode_Report_Manager
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

Validate_Update_Of_ObjectAggregation_And_DataIntegrity_In_Edit_Mode_Report_Manager
    [Tags]     Report_Manager         PMEX_CDB       NetAn_UG_PMEX_TC35
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes    CCDM01
	Click on scroll down button     6    20
    Select the Aggregation    No Aggregation   
    Select the measure type    COUNTER   
    Select KPIs    ERIC-ACT-MAPI-REQUESTS-RECV.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    click on button    Fetch PM Data
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Select The Created Report    ${report_name}
	Click on Edit button
	Check the Show Selection Panel checkbox
	edit the Aggregation    Node
	click on the button    Data Integrity Check
	click on button    Update PM Data
	sleep    40s
	click on button    Save Report	
	validate the page title    Save Report
	${report_name}=    Enter details to save report to library    Report_    Public    test
	Click on Save report to Library button
	Capture page screenshot