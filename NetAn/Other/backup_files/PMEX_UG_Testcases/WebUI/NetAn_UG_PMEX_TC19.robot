*** Settings ***
Documentation     Validate That The Measure Mapping Is Kept As A Single_Word
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

Validate That Measure Mapping Is Kept As A Single Word
    [Tags]      PMEX_CDB        Admin_Page     NetAn_UG_PMEX_TC19
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	verify that 'Measure Mapping' is kept as a single word
	Capture page screenshot
