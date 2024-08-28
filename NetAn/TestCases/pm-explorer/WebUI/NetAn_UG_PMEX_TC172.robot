*** Settings ***

Documentation     Check if the flex-filter values are properly fetched from ENIQ 
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***
	
Check if the flex-filter values are properly fetched from ENIQ   
    [Tags]      PMEX_CDB    Report_Manager 
	Open Pm Explorer Analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    click on scroll down button        6       30
    Select Aggregation as    No Aggregation
    Click on Refresh nodes button 
    Select Nodes as    ERBS1
    Select the measure type    FLEX_COUNTER
    Select KPIs    PMFLEXZTEMPORARY5.DC_E_ERBS_EUTRANCELLFDD_FLEX_RAW
    Set FlexFilterValues to     Custom
    Fetch Flex filter values
    Verify Flex filter values appear in the listbox
	Capture page screenshot
