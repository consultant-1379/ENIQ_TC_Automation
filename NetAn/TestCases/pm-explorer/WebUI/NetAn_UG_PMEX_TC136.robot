*** Settings ***
Documentation     Verifying Delete Popup Closure Using X Symbol And Escape Icon
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verifying Delete Popup Closure Using X Symbol And Escape Icon
    [Tags]     PMEX_CDB          Collection_Manager
	open pm explorer analysis
	
	Click on Collection Manager button 
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCES
	click on the scroll down button    6    12
	click on button    Fetch nodes
	select the Nodes    CCES01
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	select the created collection and click on delete    ${collectionName}
	close the delete popup using X symbol
	Capture page screenshot
	
 