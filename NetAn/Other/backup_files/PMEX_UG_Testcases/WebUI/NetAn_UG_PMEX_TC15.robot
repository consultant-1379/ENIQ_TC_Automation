*** Settings ***
Documentation     Validate That A Message Is Present If The Analysis Is Not Saved With NetAn Details
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

Validate That A Message Is Present If The Analysis Is Not Saved With NetAn Details
    [Tags]     Admin_Page    PMEX_CDB      NetAn_UG_PMEX_TC15
	open pm explorer analysis
	sleep    20s
	Click on Administration button
	validate the page title    Administration
    clear all fields in NetAn Connection
	validate that the message is present if analysis is not saved with NetAn details
	Capture page screenshot
	
	