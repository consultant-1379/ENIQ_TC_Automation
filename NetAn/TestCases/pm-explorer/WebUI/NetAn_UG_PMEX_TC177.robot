*** Settings ***

Documentation     create waterfallgraph into the Report
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

Report creation with waterfall chartTyepe
    [Tags]      PMEX_CDB      Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBSG201
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    ifTotalLossOfSignalDuration.DC_E_TCU_ETHERNETPORT_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
	Change the View to    Editing
	Change the Visualization type to Waterfall chart    
    Click Save report button
    ${report_name}=    Enter details to save report to library    Chart_Water    Public    test
    Click on Save report to Library button
    select the created report    ${report_name}
    Click on Edit button
    Check the Show Selection Panel checkbox
	click on scroll down button    8    12
	Select the Nodes    ERBS1
	click on the button    Data Integrity Check
	sleep    2
	click on the button    Update All Pages
	sleep    2
    click on button    Update PM Data
    click on button    Save Report
	Click on Save report to Library button
	select the created report    ${report_name}
	Verify the graph list is displayed for report    WaterfallChart
	Click on View button
    Capture page screenshot
	

 