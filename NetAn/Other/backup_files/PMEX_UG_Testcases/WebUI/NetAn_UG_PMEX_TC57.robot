*** Settings ***

Documentation     Validate Listbox Items for Get Data For Dropdown
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate Listbox Items for Get Data For Dropdown
	[Tags]       PMEX_CDB    Report_Manager    NetAn_UG_PMEX_TC57
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    sleep    20
    Click on scroll down button    6    15
    click on the Get Data For dropdown
    verify the list items in Get Data For dropdown
    Capture page screenshot