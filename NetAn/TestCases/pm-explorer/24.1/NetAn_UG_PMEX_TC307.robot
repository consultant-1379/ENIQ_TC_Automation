*** Settings ***

Documentation     Check the Report and pivot table Is Generated for custom Flex MultiTable KPI 
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Check the Report and pivot table Is Generated for custom Flex MultiTable KPI 
    [Tags]     PMEX_CDB       EQEV-134871
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
    Select the KPIs       flex-multitable
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as    Day
	Click on fetch pmdata button
	capture page screenshot
	Verify the page title    No Aggregation      NetAn_ODBC     FLEXPIVOT
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
	capture page screenshot
    