*** Settings ***
Documentation     View A Report Which Has More Than One Page In It And Verify Filters in all the pages
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

View A Report Which Has More Than One Page In It And Verify filters in all the pages
	[Tags]     PMEX_CDB     EQEV-131195
	open pm explorer analysis
	click on the scroll down button    0    20
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       CCDM01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    eric-udr-nudr-dr-proxy-requests-sent.DC_E_CCDM_UDR_NUDR_DR_PROXY_RAW,eric-udr-app-counter-5gsubin.DC_E_CCDM_UDR_APP_COUNTER_PREDEF_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Fill the row count       6
    Click on fetch pmdata button
    Click Save report button
    ${report_name}=    Enter details to save report to library    Report    Public    test
    Click on Save report to Library button
    Select the report     ${report_name}
	Click on View button
    Check the Show Selection Panel checkbox
    Verify the row counts in all the pages       6
	Capture page screenshot

