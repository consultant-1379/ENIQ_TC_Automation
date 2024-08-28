*** Settings ***
Documentation     Verify that if we click on Administration button it navigates to Administration Page
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

Verify that if we click on Administration button it navigates to Administration Page
    [Tags]      PMEX_CDB          Admin_Page     NetAn_UG_PMEX_TC42
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
    Capture page screenshot