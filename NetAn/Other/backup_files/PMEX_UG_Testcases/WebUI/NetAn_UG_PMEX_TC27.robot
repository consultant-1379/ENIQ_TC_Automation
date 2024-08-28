*** Settings ***

Documentation     Validate EDIT Page in Collection Manager page
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


*** Test Cases ***

Validate EDIT Page in Collection Manager page And LadtModifiedOn Column
    [Tags]      PMEX_CDB          Collection_Manager    NetAn_UG_PMEX_TC27
	Open pm explorer analysis with another user
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button    6    7
	select the Node type    CCES
    Select Access Type
	Click on Fetch Nodes
	select the Nodes    CCES01
	click on button    Add >>
	save the collection in collection manager page
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName1}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button    6    7
	select the Node type    CCES
	Select Access Type
	Click on Fetch Nodes
	select the Nodes    CCES01
	click on button    Add >>
	save the collection in collection manager page
	validate the page title    Manage Collection
	Close Browser
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	select created collection and verify selected node is present in Edit page    ${collectionName1}    CCES01
	verify error message if already existing name is entered while editing report    ${collectionName}    ${collectionName1}
	Select Access Type     Public
	check the Dynamic Collection check box
	enter Wildcard Expression    FDN like '%ROOT%'
	click on button    Preview
	save the dynamic collection in edit mode
	validate the page title    Manage Collection
	verify that the column LastModifiedOn is present
	Capture page screenshot