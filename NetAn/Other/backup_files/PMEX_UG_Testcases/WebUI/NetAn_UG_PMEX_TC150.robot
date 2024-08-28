*** Settings ***
Documentation     Report creation with input 'Get data for' Dropdown Node(s) and object aggregation for 'NODE'
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot



*** Test Cases ***

Report creation with input 'Get data for' Dropdown Node(s) and object aggregation for 'NODE' 
    [Tags]     PMEX_CDB          Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes    G2RBS01
    Select the Aggregation    Node
    Select the measure type    COUNTER   
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 7 Days  
    Select Aggregation in select time as     ROP  
    Click on fetch pmdata button
    Verify the page title    Node      NetAn_ODBC     ROP
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
	
