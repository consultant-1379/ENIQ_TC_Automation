*** Settings ***
Documentation     Verify While Saving Reports Access Dropdown Is By Default Private If Private Collection Is Selected
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


*** Test Cases ***

Verify While Saving Reports Access Dropdown Is By Default Private If Private Collection Is Selected
    [Tags]    Collection_Manager       Report_Manager            PMEX_CDB
	open pm explorer analysis
	Click on Collection Manager button 
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
    ${collectName}=    Enter the Collection name
    Select DataSource as    NetAn_ODBC
    Select System area and verify none value is not present    Radio
    Select Node type    ERBS
    click on scroll down button    6    20
    Click on Fetch Nodes
    Select Access Type
    Select Nodes    ERBS1
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectName}
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Collection
    click on scroll down button    6    20
    Select Collection    ${collectName}
    Select Aggregation    No Aggregation
    click on scroll down button    9    20  
    Select MOClass as empty and verify error message and fetch pmdata button is disbaled
    Select the KPIs    VoIP Cell Integrity
    Select time drop down to      Last 7 Days  
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
	Click on Save Report
	Verify that the dropdown is disabled in Save report
	