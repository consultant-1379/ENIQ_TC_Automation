*** Settings ***
Documentation     View A Report Which Has Custom Flex KPI 
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

View A Report Which Has Custom Flex KPI
	[Tags]     PMEX_CDB     EQEV-134871
	Open PM Explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBS1
    click on scroll down button        6       30
    Select Aggregation    No Aggregation 
    Select the measure type  CUSTOM_KPI
    Select the KPIs       Flex_customkpi
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as    Day
	Click on fetch pmdata button
	capture page screenshot
	Verify the page title    No Aggregation      NetAn_ODBC     FLEXPIVOT
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	select the created report    ${report_name}
	Click on View button
    Check the Show Selection Panel checkbox
    click on scroll down button    8    12
	Select Nodes in edit mode    ERBS2
	Click on data integrity check box
	Click on update all pages check box
	Click on update pmdata button
	verify that node name updated in all pages             ERBS2
	Capture page screenshot

