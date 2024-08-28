*** Settings ***
Documentation     Verify If The Report Not Used It Can Be Deleted Collection Button Will Notify
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

Verify If The Report Not Used It Can Be Deleted Collection Button Will Notify
    [Tags]       PMEX_CDB        Collection_Manager       NetAn_UG_PMEX_TC39
	Open pm explorer analysis with another user
    Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Radio
	select the Node type    NR
	Select Access Type
	Click on Scroll down button      6       15
	click on button    Fetch nodes
	select the Nodes    G2RBS01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	Close Browser
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection   
	Verify the delete message        ${collectionName}
	Capture page screenshot

 