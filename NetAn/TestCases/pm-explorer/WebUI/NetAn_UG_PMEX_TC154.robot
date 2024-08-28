*** Settings ***
Documentation     Adding Calculated Column To A Created Report And Verifying It In Edit Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Adding Calculated Column To A Created Report And Verifying It In Edit Page
    [Tags]    Report_Manager     PMEX_CDB
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as      ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select the KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP6_RAW,aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    Click on fetch pmdata button			   
    Change the View to    Editing
    select a column to add to the report
    add a calculated column
    Click Save report button
    ${report_name}=    Enter details to save report to library    TR-Report    Public    test
    Click on Save report to Library button
    select the created report    ${report_name}
	Click on Edit button
	sleep    30
	verify that the calculated column is added to the report
	Capture page screenshot
	
