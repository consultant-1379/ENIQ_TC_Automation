*** Settings ***

Documentation     Validate Added DataSource is present in Collection Creation
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

Validate Added DataSource is present in Collection Creation
    [Tags]      PMEX_CDB     Collection_Manager     NetAn_UG_PMEX_TC47
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	click on button    Create Collection
	validate the page title    Create Collection
	enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	click on the scroll down button    6    7
	select the Node type    CCES
	Click on scroll down button    6    20
	Click on Fetch Nodes
	select the Nodes    CCES01
	verify that the row count is 0 and Create button is disabled
	click on button    Add >>
	verify that the row count is not 0 and Create button is enabled
	click on button    Save
	validate the page title    Manage Collection
	Capture page screenshot