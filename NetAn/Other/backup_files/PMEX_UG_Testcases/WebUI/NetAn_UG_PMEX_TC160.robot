*** Settings ***

Documentation     Validate Dynamic collection in Collection Manager page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Validate Dynamic collection in Collection Manager page
    [Tags]     PMEX_KGB     Collection_Manager
    open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	click on button    Create Collection
	validate the page title    Create Collection
	verify that Add, Remove, Fetch nodes and Import nodes from File buttons are disabled
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on scroll down button    6    5
	select the Node type    CCES
	click on scroll down button    6    20
	check the Dynamic Collection check box	
	click on scroll down button    3    20
	enter Wildcard Expression    FDN like '%ROOT%'
	click on button    Preview
	click on button    Save
	validate the page title    Manage Collection
	Verify that the Collection is created    ${collectionName}
  
 