*** Settings ***
Documentation     Validate the report geenration for Subnetwork and object aggregation as subnetwork
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

Validate Report Generation For PDF Counter SubNetwork Obj Agg Level
    [Tags]       PMEX_CDB      Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    SubNetwork
    select SubNetwork    G2RBS01
    Select Aggregation as    SubNetwork
    Select the measure type    PDF_COUNTER   
    Select KPIs    pmRadioUeRepCqi64QamRank4Distr.DC_E_NR_NRCELLDU_V_RAW
    verify the drop down for PDF counter is set to 'ALL'
    Select time drop down to      Last 7 Days  
    Select Aggregation in select time as     ROP  
    Click on fetch pmdata button
    Verify the page title    SubNetwork      NetAn_ODBC     ROP
    Verify columns displayed    SubNetwork
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
 