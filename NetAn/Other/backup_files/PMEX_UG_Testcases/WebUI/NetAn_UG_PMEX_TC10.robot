*** Settings ***
Documentation     Check The Report Table Whether Report Is Generated Or Not 
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot



*** Test Cases ***

Check The Report Table Whether Report Is Generated With_Proper Data For Selected Month Or Not 
    [Tags]      PMEX_CDB        Report_Manager        NetAn_UG_PMEX_TC10
    open pm explorer analysis
    Click on scroll down button    0    20
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Click on scroll down button    6    20
    Select Node type    CCDM
    Select Get Data For    Node(s)   
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select Aggregation    No Aggregation
    Select the measure type   COUNTER
    Select the KPIs        eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Calendar Interval
    Select Aggregation in select time as    Month
	Enter the Calendar Interval           07/08/2023    07/12/2023
	Click on fetch pmdata button
	Verify the page title    No Aggregation      NetAn_ODBC     Month
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
   
