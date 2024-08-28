*** Settings ***
Documentation     Validate If Other User Edit Public Collection Access Button Will Be Inactive
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

Validate If Other User Edit Public Collection Access Button Will Be Inactive
    [Tags]    Collection_Manager        PMEX_CDB
	Open pm explorer analysis with another user
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
    Close Browser
    open pm explorer analysis
	Click on Collection Manager button 
	validate the page title    Manage Collection
	select the created collection and click on edit    ${collectName}  
	validate the page title    Create Collection
	click on scroll down button    6    15
	verify that the dropdown is disabled
	