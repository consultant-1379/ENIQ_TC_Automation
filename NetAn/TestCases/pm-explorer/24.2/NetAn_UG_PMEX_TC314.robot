*** Settings ***
Documentation     Creating Sharing Group KPI with Calculated Column External TR: IA85008
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

Adding Calculated Column To A Created Report And Verifying It In Edit Page
    [Tags]    Report_Manager     PMEX_CDB     PMEX_KGB     NetAn_UG_PMEX_TC314
	open pm explorer analysis	
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    RadioNodeMixed01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    pmMacVolUl.DC_E_NR_NRCELLDU_RAW
    Select time drop down to      Last 7 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    click on Measure Selection page button
    Select Node type    ERBS
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    RadioNodeMixed01
    Select the measure type    COUNTER
    Select KPIs    pmRadioThpVolUl.DC_E_ERBS_EUTRANCELLFDD_RAW
    Select KPIs    pmPuschSchedActivity.DC_E_ERBS_SHARINGGROUP_RAW
    Click on fetch pmdata button
    Add columns from first Data table
    Add columns from second Data table
    Add columns from third Data table
	Navigate to next page    pm_DC_E_ERBS_EUTRANCELLFDD_DAY(No Aggregation Level)__NetAn_ODBC
    Add Calculated column and verify if the column is added
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Private    test
    Click on Save report to Library button
	[Teardown]       Test teardown steps for webUI