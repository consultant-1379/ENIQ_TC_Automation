*** Settings ***
Documentation     Validate Deletion of a Dynamic Collection
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Deletion of a Dynamic Collection
    [Tags]      PMEX_CDB     Collection_Manager     NetAn_UG_PMEX_TC49
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	check the Dynamic Collection check box
	enter Wildcard Expression    FDN like '%ROOT%'
	click on button    Preview
	click on button    Save
	validate the page title    Manage Collection
	select the created collection and delete it    ${collectionName}
	verify that the deleted collection is not present    ${collectionName}	
	Capture page screenshot
	
 