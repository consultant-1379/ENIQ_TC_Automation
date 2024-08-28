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
Library			  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Scripts/IronPythonScripts/KeyboardActions.py

*** Test Cases ***

Check The Report Table Whether Report Is Generated Or Not
	[Tags]       PMEX_CDB       Report_Manager    NetAn_UG_PMEX_TC09
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Click on scroll down button    6    20
    Select Node type    CCDM
    Select Get Data For    Node(s)
    click on scroll down button        6       30
    Select Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes as      CCDM01
    Select the measure type   COUNTER
    Select the KPIs        eric-act-ldap-prov-requests-sent.DC_E_CCDM_ACT_LDAP_PROV_RAW
    Select time drop down to      Calendar Interval
    Select Aggregation in select time as    Month
	Enter the Calendar Interval           01/11/2022    08/12/2022
	Click on fetch pmdata button
	Sleep           20
	Verify the page title    No Aggregation      NetAn_ODBC     Month
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test