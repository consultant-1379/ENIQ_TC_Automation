*** Settings ***
Documentation     Validate That NodeName Is Added As A Separate Column In Collection Manager
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

Validate That NodeName Is Added As A Separate Column In Collection Manager
    [Tags]     PMEX_CDB     Collection_Manager     NetAn_UG_PMEX_TC22
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	verify that NodeName is added as a separate column
	Capture page screenshot
	

 