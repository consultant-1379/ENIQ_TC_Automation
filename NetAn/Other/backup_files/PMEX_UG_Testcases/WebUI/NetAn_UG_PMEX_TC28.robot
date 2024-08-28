*** Settings ***
Documentation     Validate Editing A Collection With Pre-existing Collection Name
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

Validate Editing A Collection With Pre-existing Collection Name
    [Tags]     PMEX_CDB          Collection_Manager     NetAn_UG_PMEX_TC28
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
    Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Radio
	select the Node type    ERBS
	Click on scroll down button     6    20
	click on button    Fetch nodes
	select the Nodes    ERBS1
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	click on button    Create Collection
	validate the page title    Create Collection
	${collectionName1}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Radio
	select the Node type    ERBS
	Click on scroll down button     6    20
	click on button    Fetch nodes
	select the Nodes    ERBS1
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	select the created collection and click on edit    ${collectionName1}
	Enter Collection name    ${collectionName}
	save the collection in edit page
	verify the message Collection name already exists
	Capture page screenshot
	