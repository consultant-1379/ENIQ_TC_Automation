*** Settings ***
Documentation     Verify No Matching DataSources Message in Create Information Link(s) Page
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

Verify No Matching DataSources Message in Create Information Link(s) Page
    [Tags]     PMEX_CDB          Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    4140_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER   
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      4140_ODBC     Day
	click on button    Create Information Link(s)
	validate the page title    Create Information Link(s)
	validate that No Matching DataSources found 
	Capture page screenshot