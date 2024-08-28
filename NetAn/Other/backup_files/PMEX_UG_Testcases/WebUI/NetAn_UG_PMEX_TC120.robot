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

*** Test Cases ***

Validate The Access Dropdown Is Disabled If Public Collection Is Being Used
    [Tags]    Collection_Manager        Report_Manager         PMEX_CDB
	open pm explorer analysis
	Click on Collection Manager button 
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
    ${collectName}=    Enter the Collection name
    Select DataSource as    NetAn_ODBC
    Select System area    Radio
    Select Node type    NR
    click on scroll down button    6    20
    Click on Fetch Nodes
    Select Nodes    G2RBS01
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectName}
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Collection
    click on scroll down button    6    20
    Select Collection    ${collectName}
    Select Aggregation    No Aggregation
    Select the measure type    COUNTER   
    Select KPIs    pmDrbRopEndSa.DC_E_NR_NRCELLCU_RAW
    Select time drop down to      Last 30 Days  
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	click on button     Collection Manager
	validate the page title    Manage Collection
	select the created collection and click on edit    ${collectName}  
	validate the page title    Create Collection
	click on scroll down button    6    15
	verify that the dropdown is disabled
	Verify the Access Type warning Message is Visible  
	