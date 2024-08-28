*** Settings ***
Documentation     Validate 'Sync with Eniq' message in Administration Page
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

Validate 'Sync with Eniq' message in Administration Page
    [Tags]     Admin_Page    PMEX_CDB
	open pm explorer analysis
	click on the scroll down button    0    15
	Click on Administration button
	verify that sync is done successfully
    Capture page screenshot
