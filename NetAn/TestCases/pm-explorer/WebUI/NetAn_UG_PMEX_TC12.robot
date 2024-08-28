*** Settings ***

Documentation     Testing Core Nodetypes
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Library			  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Scripts/IronPythonScripts/KeyboardActions.py


*** Test Cases ***

Edit The Report Generated With Existing Datetime Interval And Month Aggregation
    [Tags]      PMEX         Report_Manager        NetAn_UG_PMEX_TC12
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    NR
    Select Get Data For as    Node(s)
    click on scroll down button        6      30
    Select Aggregation    No Aggregation
    click on scroll up button       6       7
    Click on Refresh nodes button
    Select Nodes as    G2RBS01    
    Select the measure type   COUNTER
    Select KPIs        aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Verify if fetch pm data button is disabled
	Select time drop down to      Existing Interval Definitions
    Select Aggregation in select time as    Month
    Verify if fetch pm data button is enabled
    select an existing interval
	Check the Data Integrity Check box and Fetch PM Data
	Verify the page title    No Aggregation      NetAn_ODBC     Month
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	Verify saved report available in Report manager GUI     ${report_name}    Public   test
    Verify that the report is saved to the DB     ${report_name}
 	select the created report    ${report_name}
 	click on Edit button
 	verify that the Edit page is visible
	Close the Edit page
	Select the report    Old_Report_Check_Latest_Package
	Click on Edit button
	Check for the error notification is not present
