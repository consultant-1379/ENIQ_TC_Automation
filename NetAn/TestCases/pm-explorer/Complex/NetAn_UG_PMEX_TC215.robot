*** Settings ***
Library           DatabaseLibrary
Library           AutoItLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}


*** Test Cases ***

Validate That 'Hour of Day Filter' Is Disabled For Aggregations Other Than HOUR and ROP
    [Tags]      PMEX_CDB    Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as     G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER
    Select KPIs    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day
    validate that Hour Of Day filter is disabled for Aggregations other than Hour and ROP
    Capture page screenshot
   
    

 