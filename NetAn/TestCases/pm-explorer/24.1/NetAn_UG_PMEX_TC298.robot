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
    Sleep     5s
    Click on Create button
    Sleep    2s
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    sctpOutOfBlues.DC_E_TCU_SCTP_RAW,severelyErroredSecondsHC.DC_E_TCU_E1T1PORT_RAW,succeededEl2tpControlConnectionsHC.DC_E_TCU_TGTRANSPORT_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on button    Fetch PM Data
    Click Save report button
    ${report_name}=    Enter details to save report to library    Report    Public    test
    Click on Save report to Library button
    Select the report     ${report_name}
	Click on Edit button
	sleep    20
    Check the Show Selection Panel checkbox
    click on scroll down button    8    12
	Select the Nodes    ERBS2
    Verify the available filters
	click on the button    Update All Pages
	sleep    2
	Click on update pmdata button
	Verify the available filters in all other pages
    sleep    20
	Capture page screenshot

