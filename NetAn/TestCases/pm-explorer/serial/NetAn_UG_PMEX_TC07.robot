*** Settings ***

Documentation     Check If The Report Is Generated With Proper Data For Selected Month or Not 
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

Check If The Report Is Generated With Proper Data For Selected Month or Not 
    [Tags]     PMEX_CDB       Report_Manager      NetAn_UG_PMEX_TC07
    Open PM Explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBSG201
    click on scroll down button        6       30
    Select Aggregation    No Aggregation      
    Select the measure type  COUNTER,FLEX_COUNTER
    Select the KPIs        aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Calendar Interval
    Select Aggregation in select time as    ROP
	Enter the Calendar Interval           01/04/2024       30/12/2024
	Click on fetch pmdata button
	capture page screenshot
	Verify the page title    No Aggregation      NetAn_ODBC     RAW
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
 	select the created report    ${report_name}
	Click on scroll down button      1          1
    Click on View button
    verify that the month_id value in datetime_id    12
   
