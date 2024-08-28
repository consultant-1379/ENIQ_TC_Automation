*** Settings ***
Documentation     Edit A Report Which Has More Than One Page In It And Verify Filters in all the pages
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

Edit A Report Which Has More Than One Page In It And Verify filters in all the pages
	[Tags]     PMEX_CDB     EQEV-131195
	open pm explorer analysis
	click on the scroll down button    0    20
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBSG201,ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER,ERICSSON_KPI,RI
    Select KPIs    Accessibility Failure Rate due to Connected Users License,aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW,Added E-RAB Establishment Success Rate
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Fill the row count       10
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    Report    Public    test
    Click on Save report to Library button
    Select the report     ${report_name}
	Click on Edit button
    Check the Show Selection Panel checkbox
	click on the button    Update All Pages
    Click on button     Measure Selection 
    Fill the row count       5
	Click on button    Fetch PM Data
    Verify the row counts in all the pages       5
	Capture page screenshot

