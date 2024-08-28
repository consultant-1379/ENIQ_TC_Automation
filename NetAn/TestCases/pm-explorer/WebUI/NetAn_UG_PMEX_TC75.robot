*** Settings ***
Documentation     Verify That the Column MeasureName is Present in Report Manager Page
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

Verify That the Column MeasureName is Present in Report Manager Page
    [Tags]     Report_Manager    PMEX_CDB        NetAn_UG_PMEX_TC75
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Select Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select the measure type    COUNTER   
    Select KPIs    eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Last 30 Days  
    Select Aggregation in select time as     Day  
    Click on Fetch PMData button
    Verify the page title    No Aggregation    NetAn_ODBC    Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	verify that the MeasureName column is present and contains the measure   eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
	Capture page screenshot
	
