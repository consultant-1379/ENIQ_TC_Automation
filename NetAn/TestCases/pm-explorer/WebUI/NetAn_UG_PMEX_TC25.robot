*** Settings ***
Documentation     Validate That SubNetwork Viewer Is Added As A Separate Section In Collection Manager
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

Validate That SubNetwork Viewer Is Added As A Separate Section In Collection Manager
    [Tags]      PMEX_CDB            Collection_Manager       NetAn_UG_PMEX_TC25
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	verify that the SubNetwork Viewer is added as a different Section

 