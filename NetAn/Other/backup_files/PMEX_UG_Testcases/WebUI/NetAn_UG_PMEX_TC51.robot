*** Settings ***

Documentation     Validate Dyamic Collection Creation in Collection Manager
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

Validate Dyamic Collection Creation in Collection Manager
	[Tags]   PMEX_CDB     Collection_Manager     NetAn_UG_PMEX_TC51						   
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on scroll down button    6    7
	select the Node type    CCES
	Click on scroll down button    6    20
	check the Dynamic Collection check box
	verify alert message shows up for incorrect syntax in Wildcard Expression
	verify alert message if Wildcard Expression field is empty
	verify alert message if we click on Create while Wildcard Expression field is empty
	enter Wildcard Expression    FDN like '%ROOT%'
	click on button    Preview
	click on button    Save
	validate the page title    Manage Collection
	Capture page screenshot