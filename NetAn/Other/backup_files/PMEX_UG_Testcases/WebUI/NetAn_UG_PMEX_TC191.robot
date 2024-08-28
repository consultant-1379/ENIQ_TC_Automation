*** Settings ***

Documentation     Verify that consumer user is not able to create/edit/delete collections
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***
	
Verify that consumer user is not able to create/edit/delete collections 
    [Tags]      PMEX_CDB    Collection_Manager 
	Open pm explorer analysis with another user    Consumer    Ericsson01
	click on button     Collection Manager
    Validate the page title      Manage Collection
    Verify create edit and delete buttons atre not visible in the page
	Capture page screenshot
