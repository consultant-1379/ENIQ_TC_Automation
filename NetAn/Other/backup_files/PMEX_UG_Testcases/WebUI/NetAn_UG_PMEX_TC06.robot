*** Settings ***

Documentation     Check If Report Is Getting Generated For Existing Datetime Interval With Month Aggregation And Data Integrity Checked
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


*** Test Cases ***

Check If Report Is Getting Generated For Existing Datetime Interval With Month Aggregation And Data Integrity Checked
    [Tags]      PMEX_CDB    Report_Manager      NetAn_UG_PMEX_TC06
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Click on scroll down button    6    20
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as    CCDM01
    Select Aggregation    No Aggregation
    Select the measure type   COUNTER
    Select the KPIs        eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Define Interval
    Select Aggregation in select time as    Month
	${intervalName} =    Create an Interval    Interval    28/08/2022    06/09/2022
	Select time drop down to      Existing Interval Definitions
	select an interval    ${intervalName}
	Check the Data Integrity Check box and Fetch PM Data
	Verify the page title    No Aggregation      NetAn_ODBC     Month
