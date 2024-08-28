*** Settings ***
Documentation     Validate Message Is Added In Edit Mode Collection Manager Page
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

Validate Message Is Added In Edit Mode Collection Manager Page
    [Tags]     Collection_Manager      PMEX_CDB      NetAn_UG_PMEX_TC31
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Radio
	select the Node type    ERBS
	click on the scroll down button    6    12
	click on button    Fetch nodes
	select the Nodes    ERBS1,ERBS2
	click on button    Add >>
	Click on scroll up button    6    12
	Verify error message when creating the alarm without collection name
	${collectionName}=    enter the Collection name
	click on button    Save
	validate the page title    Manage Collection
	select the created collection and click on edit    ${collectionName}
	verify that the message is added to the Create Collection Page
	Verify error message when saving the alarm without collection name
	Capture page screenshot