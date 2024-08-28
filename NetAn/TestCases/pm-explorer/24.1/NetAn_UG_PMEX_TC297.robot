*** Settings ***

Documentation     View A Report And Verify Filters in the Report Page 
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

*** Test Cases ***

View A Report And Verify Filters in the Report Page
    [Tags]     PMEX_CDB		EQEV-131195
    Open PM Explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBSG201
    Select Aggregation    No Aggregation      
    Select the measure type  COUNTER,FLEX_COUNTER
    Select the KPIs        pmFlexCellHoPrepSuccNr.DC_E_ERBS_EUTRANCELLFDD_FLEX_RAW
    Select time drop down to      Calendar Interval
    Select Aggregation in select time as    ROP
	Enter the Calendar Interval           04/07/2023       08/07/2023
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
    Verify the available filters
    
   
