*** Settings ***

Documentation     Validate that public Collections can be modified by non-owners except Access Type field- for non-admin users.
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
																														  
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

*** Test Cases ***

Validate that public Collections can be modified by non-owners except Access Type field- for non-admin users
    [Tags]		PMEX_CDB		Collection_Manager
	open pm explorer analysis
	Click on Collection Manager button
	Validate the page title    Manage Collection
	Click on Create Collection button
	Validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core										  
	select the Node Type    CCES
	Click on scroll down button    6    20
	check the Dynamic Collection check box
	enter Wildcard Expression    NodeName like '%CCES%'
										   
	Click on the Preview button
	
	click on button    Save
	Validate the page title    Manage Collection
	Close Browser
	Open pm explorer analysis with another user
	Click on Collection Manager button
	select the created collection and click on edit    ${collectionName}										 
	Click on scroll down button    5    20
	verify that the dropdown is disabled
	uncheck The Dynamic Collection check box
	Click on Fetch Nodes 
	select the Nodes    CCES01
	click on button    Add >>
	save the collection in edit page
	Validate the page title    Manage Collection
	verify ModifiedBy column in Collection Manager page after Collection is modified    ${collectionName}
	Capture page screenshot
	
