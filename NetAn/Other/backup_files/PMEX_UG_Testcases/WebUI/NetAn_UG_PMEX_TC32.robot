*** Settings ***
Documentation     Validate ModifiedBy Column In Node Collection Table In Collection Manager Page
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

Validate ModifiedBy Column In Node Collection Table In Collection Manager Page
    [Tags]      Collection_Manager     PMEX_CDB        NetAn_UG_PMEX_TC32
	open pm explorer analysis 
	click on Collection Manager button
	validate the page title    Manage Collection
	verify that the column ModifiedBy is present
	Capture page screenshot
	