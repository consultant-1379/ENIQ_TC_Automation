*** Settings ***
Documentation     Verify Edit Operation For Reports For Different System Area
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

Verify Edit Operation For Reports For Different System Area
    [Tags]     PMEX_CDB          Report_Manager
	open pm explorer analysis
	
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as    ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    sctpOutOfBlues.DC_E_TCU_SCTP_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Public    test
    Click on Save report to Library button
	select the created report    ${report_name}
	Click on Edit button
	Check the Show Selection Panel checkbox
	sleep    20
	verify that Get Data For has proper value selected    Node(s)
	verify that Node Type has correct value selected    ERBS
	verify that Data Source has proper value selected    NetAn_ODBC
	verify that Object Aggregation has proper value selected    No Aggregation
	click on the scroll down button    8    12
	verify that the correct Node is selected    ERBS1
	verify that Preceding Period has proper value selected    Last 30 Days
	verify that Aggregation has proper value selected    Day
	Click on update pmdata button
	sleep    30
	Close the Edit page
	validate the page title    Report Manager
	Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCES
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as    CCES01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    eric-apigm-api-proxy-fetch-public-key-error.DC_E_CCES_APIGM_APIPROXY_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    Click Save report button
    ${report_name1}=    Enter details to save report to library    TR-Report    Public    test
    Click on Save report to Library button
	select the created report    ${report_name1}
	Click on Edit button
	Check the Show Selection Panel checkbox
	sleep    20
	verify that Get Data For has proper value selected    Node(s)
	verify that Node Type has correct value selected    CCES
	verify that Data Source has proper value selected    NetAn_ODBC
	verify that Object Aggregation has proper value selected    No Aggregation
	click on the scroll down button    8    12
	verify that the correct Node is selected    CCES01
	verify that Preceding Period has proper value selected    Last 30 Days
	verify that Aggregation has proper value selected    Day
	Click on update pmdata button
	sleep    30
	Close the Edit page
	validate the page title    Report Manager
	Capture page screenshot
	