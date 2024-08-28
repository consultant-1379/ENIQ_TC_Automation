*** Settings ***

Documentation     Check the Report Is Generated for PDFKPI if there is no data 
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

Check the Report Is Generated for PDFKPI if there is no data
    [Tags]     PMEX_CDB      Report_Manager
    Open PM Explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    RBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       RadioNodeMixed01
    click on scroll down button        6       30
    Select Aggregation    No Aggregation 
    Select the measure type  ERICSSON_KPI
    Select the KPIs       PacketintHs_I_DlTp 
    Select time drop down to      Last 12 Hours
    Select Aggregation in select time as    ROP
	Click on fetch pmdata button
	capture page screenshot
	Verify the page title    No Aggregation      NetAn_ODBC     RAW
	Verify save report page for no data
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
	
	
    