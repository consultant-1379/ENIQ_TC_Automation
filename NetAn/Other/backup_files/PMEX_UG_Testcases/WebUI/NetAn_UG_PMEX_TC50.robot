*** Settings ***

Documentation     Validate Deletion of a Static Collection
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

Validate Deletion of a Static Collection
    [Tags]     PMEX_CDB      Collection_Manager    NetAn_UG_PMEX_TC50
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	click on button    Create Collection
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	check the Dynamic Collection check-box and verify Preview panel is empty
	click on button    Save
	validate the page title    Manage Collection
	validate the Collection is created with correct details    ${collectionName}    NetAn_ODBC    Core    CCES
	select the created collection and delete it    ${collectionName}
	verify that the deleted collection is not present    ${collectionName}	
	Capture page screenshot	
