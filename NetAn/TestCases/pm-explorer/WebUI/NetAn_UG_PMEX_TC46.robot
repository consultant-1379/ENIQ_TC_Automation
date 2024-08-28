*** Settings ***

Documentation     Check The Data Table tblSavedReports Has The Column MeasureName
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Check The Data Table tblSavedReports Has The Column MeasureName
	[Tags]       PMEX_CDB           Report_Manager    NetAn_UG_PMEX_TC46
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    ERBS
    Select Get Data For as    Node(s)
    click on scroll down button       6       30
    Select Aggregation    No Aggregation
    click on scroll up button       6       7
    Click on Refresh nodes button
    Select Nodes as        ERBS1
    Select the measure type   COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW   
    Verify if fetch pm data button is disabled
    Select time drop down to      Preceding Period    
    Select Aggregation in select time as     Day 
    Enter Preceding period     2
    Select Preceding Period Units as     Day(s)
    Select Day of the week    Monday,Tuesday 
    Verify if fetch pm data button is enabled
    Click on fetch pmdata button
	Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	change the mode to    Editing
	${available}    ${selected}=    open the properties menu and view columns    ${report_name}
	verify that the columns are present in Select Columns    ${available}    ${selected}
	Capture page screenshot