*** Settings ***

Documentation     Add graph in to the created report
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Add graph in to the created report
    [Tags]    PMEX_KGB         Report_Manager      NetAn_UG_PMEX_TC04
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    click on scroll down button        6       30
    Select the Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes as    CCDM01
	Verify that the chosen measure type changes the available measures list
    Select the measure type    COUNTER   
    Select KPIs    eric-act-ldap-prov-requests-sent.DC_E_CCDM_ACT_LDAP_PROV_RAW
    Select time drop down to      Calendar Interval
    Enter the Calendar Interval    30/08/2022    10/09/2022
    Enter the time range    01:00    23:00 
    Select Aggregation in select time as     Hour  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Hour
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Change the View to    Editing
	Change the Visualization type to Pie chart
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
    
	

 