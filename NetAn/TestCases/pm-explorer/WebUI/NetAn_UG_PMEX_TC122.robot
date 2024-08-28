*** Settings ***
Documentation     Verify The Logged In User Can See Both Private And Public Collection Only
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

Verify The Logged In User Can See Both Private And Public Collection Only
    [Tags]     Collection_Manager        PMEX_CDB
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
    Select Access Type
    Select Nodes    G2RBS01
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectName} 
    Open pm explorer analysis with another user   
	Click on Collection Manager button 
	validate the page title    Manage Collection
	verify that the collection created by Administrator is not visible    ${collectName} 
    