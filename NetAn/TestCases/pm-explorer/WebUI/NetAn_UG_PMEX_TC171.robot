*** Settings ***

Documentation     Validate the Functionality of 'Advanced Options' in Select Time Panel
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

Validate the Functionality of 'Advanced Options' in Select Time Panel
    [Tags]       PMEX_KGB        Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    NR
    Select Get Data For as    Node(s)
    click on scroll down button       6       30
    Select Aggregation    No Aggregation
    click on scroll up button       6       7
    Click on Refresh nodes button
    Select Nodes as    G2RBS01
    Select the measure type   COUNTER
    Select KPIs        PMRADIORACBFAILMSG1OOC.DC_E_NR_BEAM_RAW
    Select time drop down to      Preceding Period    
    Select Aggregation in select time as     Day 
    Enter Preceding period     2
    Select Preceding Period Units as     Day(s)
    Select Day of the week    Monday,Tuesday 
    Click on fetch pmdata button
	Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
    
 