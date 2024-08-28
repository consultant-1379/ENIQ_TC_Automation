*** Settings ***
Documentation     Validate ModifiedBy Column Is Empty For Newly Created Collection
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

Validate ModifiedBy Column Is Empty For Newly Created Collection
    [Tags]      Collection_Manager    PMEX_CDB    NetAn_UG_PMEX_TC34
	open pm explorer analysis
	click on Collection Manager button
	validate the page title    Manage Collection
	click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Radio
	select the Node type    ERBS
	Click on scroll down button    6    20
	click on button    Fetch nodes
	select the Nodes    ERBS1
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	verify that the ModifiedBy column in Collection Manager page is empty    ${collectionName}
	Capture page screenshot
	