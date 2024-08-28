*** Settings ***

Documentation     Save Report dialog for supported and unsupported chartType
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

Report creation with Save Report dialog for unsupported/Supported chartType
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
    click on button    Fetch PM Data
	Change the View to    Editing
	Change the Visualization type to Map chart
	Change the Visualization type to Pie chart	
	Click Save report button for dialog2
	Validation of text UnsupportedChart SupportedChart
    Click on Cancel button for save report dialog2
	Click Save report button for dialog2
	Click on Continue button
    ${report_name}=    Enter details to save report to library    Chart_parallel    Public    test
    Click on Save report to Library button
	Select the report    ${report_name}
	Verify the graph list is displayed for report    WebMapChart 
	Verify the graph list is displayed for report    PieChart    
    Capture page screenshot
	

 