*** Settings ***
Documentation     Verify The Delete collection Button In Collection Manager Page
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
Verify The Delete collection Button In Collection Manager Page
    [Tags]    Collection_Manager     PMEX_CDB
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	Click on Scroll down button      6       15
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	Close Browser
	Open pm explorer analysis with another user
	Click on Collection Manager button 
	validate the page title    Manage Collection   
	Verify the delete message        ${collectionName}
	Capture page screenshot