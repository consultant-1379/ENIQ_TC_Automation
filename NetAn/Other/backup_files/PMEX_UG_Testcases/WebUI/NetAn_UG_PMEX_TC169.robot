*** Settings ***

Documentation     Validate the EDIT Report Functionality in Report Manager Page
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


*** Test Cases ***

Validate the EDIT Report Functionality in Report Manager Page
    [Tags]     PMEX_CDB         Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    NR
    Select Get Data For    Node(s)
    click on scroll down button        6      30
    Select Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes    G2RBS01
    Select the measure type   COUNTER
    Select KPIs        PMRADIORACBFAILMSG1OOC.DC_E_NR_BEAM_RAW
    Select time drop down to      Preceding Period    
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
	Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Select the report    ${report_name}
	Click on Edit button
	Verify that the Edit page is visible
	Close the Edit page
	