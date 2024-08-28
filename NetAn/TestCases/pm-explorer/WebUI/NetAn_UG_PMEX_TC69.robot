*** Settings ***
Documentation     Validate_if_node_list_is_displaying_nodes_for_selected_collection
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

Validate_if_node_list_is_displaying_nodes_for_selected_collection
    [Tags]     PMEX_CDB          Collection_Manager       NetAn_UG_PMEX_TC69
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	click on button    Report Manager
	validate the page title    Report Manager
	Click on Create button
	Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCES
    Click on scroll down button    6    10
    Select Get Data For    Collection
    Click on scroll down button    6    10
    verify that the created collection is present in Collections list    ${collectionName}
	Capture page screenshot
    