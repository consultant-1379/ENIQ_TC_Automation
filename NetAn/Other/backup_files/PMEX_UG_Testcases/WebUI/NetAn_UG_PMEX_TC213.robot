*** Settings ***
Documentation     Check The Report Table Whether Report Is Generated with proper date Or Not 
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

Check The Report Table Whether Report Is Generated with Proper Date Or Not 
    [Tags]      PMEX_CDB 	Report_Manager
    open pm explorer analysis
    Click on scroll down button    0    20
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    ERBS
    Select Get Data For    Node(s)   
    Click on Refresh nodes button
    Select Nodes    ERBSG201
    Select Aggregation    No Aggregation
    Select the measure type   COUNTER
    Select the KPIs        aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Calendar Interval
    Select Aggregation in select time as    Hour
	Enter the Calendar Interval           09/01/2023    09/12/2023
	Click on fetch pmdata button
	Verify the page title    No Aggregation      NetAn_ODBC     Hour
    Sleep    20s
	Verify the date column value
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
   
