*** Settings ***

Documentation     Validate Error Message If We Try To Create A Collection With Pre-existing Name
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

Validate Error Message If We Try To Create A Collection With Pre-existing Name
    [Tags]      PMEX_CDB     Collection_Manager
    open pm explorer analysis
    Click on Collection Manager button
	validate the page title    Manage Collection
    Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	Select DataSource as    NetAn_ODBC
	verify alert message if System Area is not selected
	select the System area as    Core
	click on the scroll down button    6    7
	verify alert message if Node Type is not selected
	select the Node type    CCES
	Click on scroll down button    6    20
	check the Dynamic Collection check box
	enter Wildcard Expression    NodeName like '%CCES%'
	Click on the Preview button
	click on button    Save
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	Enter Collection name    ${collectionName}
	Select DataSource as    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button    6    7
	select the Node type    CCES
	Click on scroll down button    6    20
	check the Dynamic Collection check box
	enter Wildcard Expression    FDN like '%ROOT%'
	click on button    Preview
	click on button    Save
	verify that error message "Collection name already exists" is displayed
	validate that collection gets created after name correction
	Capture page screenshot