*** Settings ***

Documentation     In Select Time panel,select 'Existing Interval Definitions' and check the functionality
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Library			  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Scripts/IronPythonScripts/KeyboardActions.py

*** Test Cases ***

In Select Time panel,select 'Existing Interval Definitions' and check the functionality
	[Tags]       PMEX_CDB        Report_Manager       NetAn_UG_PMEX_TC40
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Click on scroll down button    6    20
    Select Get Data For as       Node(s)
    click on scroll down button        6       30
    Select Aggregation    Node
    Click on Refresh nodes button
    Select Nodes       G2RBS01
    Select the measure type   COUNTER
    Select KPIs        aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
	Select time drop down to      Existing Interval Definitions
	Select Aggregation in select time as    Hour
	select an existing interval
	Click on fetch pmdata button
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test_report
	Click on Save report to Library button