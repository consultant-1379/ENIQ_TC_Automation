*** Settings ***

Documentation     Validate Static Collection Editing in Collection Manager Page
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

Validate Static Collection Editing in Collection Manager Page
    [Tags]     PMEX_CDB          Collection_Manager     NetAn_UG_PMEX_TC61
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button    6    7
	select the Node type    CCES
	Click on Fetch Nodes
	Select Nodes    CCES01
	Click on Add >>
	verify that << Remove button removes selected node from Selected Nodes list
	Click on Save button
	validate the page title    Manage Collection
	select the created collection and click on edit    ${collectionName}
	verify that << Remove button removes selected node from Selected Nodes list on Edit page    CCES01
	verify that the DataSource, System Area and Node Type are displaying correct values    NetAn_ODBC    Core    CCES
	check the Dynamic Collection check-box and verify Preview panel is empty on Edit page
	check the Dynamic Collection check box
	verify alert message shows up for incorrect syntax in Wildcard Expression
	verify alert message if Wildcard Expression field is empty
	verify alert message if we click on Save while Wildcard Expression syntax is incorrect
	verify alert message if we click on Save while Wildcard Expression field is empty
	un-check Dynamic Collection check-box and verify Selected Nodes panel is empty on Edit page
	enter Wildcard Expression    NodeName like '%CCES%'
	click on button    Preview
	save the collection
	validate the page title    Manage Collection
	Capture page screenshot