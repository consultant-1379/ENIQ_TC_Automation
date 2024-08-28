*** Settings ***
Documentation     Validate That If Sync Failed With A DataSource It Should Not Be Present In Collection Creation
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
Validate That If Sync Failed With A DataSource It Should Not Be Present In Collection Creation
    [Tags]    Collection_Manager    PMEX_CDB        NetAn_UG_PMEX_TC16
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	Connect to Failed DB
	click on button    Deleted Items
	Click on Collection Manager button
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	Validate that the failed DataSource is not present in DataSource selection
	Capture page screenshot
	