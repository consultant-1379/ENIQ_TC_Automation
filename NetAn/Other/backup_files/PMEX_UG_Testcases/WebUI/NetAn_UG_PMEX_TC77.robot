*** Settings ***
Documentation     Verify That If We Select More Than One Collection The Edit And Delete Buttons Are Disabled
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

Verify That If We Select More Than One Collection The Edit And Delete Buttons Are Disabled
    [Tags]    Collection_Manager    PMEX_CDB        NetAn_UG_PMEX_TC77
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	click on button    Create Collection
	validate the page title    Create Collection
	${collectionName1}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	select the created collections    ${collectionName}    ${collectionName1}
	validate that the button is disabled    Edit Collection
	validate that the button is disabled    Delete Collection
	Capture page screenshot
	
 