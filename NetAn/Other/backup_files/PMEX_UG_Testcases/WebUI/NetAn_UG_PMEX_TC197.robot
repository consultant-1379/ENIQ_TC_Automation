*** Settings ***

Documentation     Validate Dynamic Collection Editing in Collection Manager Page
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify Exception If Collection Is Being Created Without NetAn Connection
    [Tags]		PMEX_CDB		Collection_Manager
	open pm explorer analysis
	click on Administration button
	break the NetAn connection
	go to Home page
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button    6    7
	select the Node type    CCES
	Click on scroll down button    6    20
	check the Dynamic Collection check box
	enter Wildcard Expression    NodeName like '%CCES%'
	click on the scroll down button    3    10
	Click on the Preview button
	click on button    Save
	verify that DataBase connection exception is visible
	Capture page screenshot