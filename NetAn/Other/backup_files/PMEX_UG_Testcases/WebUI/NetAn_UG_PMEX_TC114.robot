*** Settings ***
Documentation       Validate The Access Dropdown Is Added In Create Collection Of Dynamic Collection
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

Validate The Access Dropdown Is Added In Create Collection Of Dynamic Collection
    [Tags]      Collection_Manager       PMEX_CDB
	open pm explorer analysis
	Click on Collection Manager button 
	validate the page title    Manage Collection
	Click on Create Collection button
	validate the page title    Create Collection
	Click on scroll down button    6    20
	Check the Dynamic Collection check box
	Click on scroll down button    3    20
	sleep    5
	Click on the Access drop down button   
	