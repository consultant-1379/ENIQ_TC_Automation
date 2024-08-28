*** Settings ***
Documentation     Testing Core Nodetypes
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

Verify that if we click on 'Collection Manager' button it navigates to 'Manage Collection' Page
	[Tags]     PMEX_CDB     Collection_Manager     NetAn_UG_PMEX_TC43
	open pm explorer analysis
	verify that the button is visible    Collection Manager
	Click on Collection Manager button
	validate the page title    Manage Collection
    Capture page screenshot
	