*** Settings ***
Documentation     Validate Report Generation For Custom KPI For PDF Counter
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Report Generation For Custom KPI For PDF Counter
    [Tags]    Custom_KPI    PMEX_CDB      NetAn_UG_PMEX_TC80
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    CUSTOM_KPI
    Select KPIs    PDF_Counter
    Select time drop down to      Last 30 Days    
    Select Aggregation in select time as     Day
    Click on fetch pmdata button
    Capture page screenshot
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click Save report button
    ${report_name}=    Enter details to save report to library    Custom_KPI    Private   NA
    Click on Save report to Library button
    Verify saved report available in Report manager GUI   	  ${report_name}  	  Private  	 NA
    Verify that the report is saved to the DB  	   ${report_name}
 