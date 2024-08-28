*** Settings ***
Documentation     PMEX-verify that Access Busy Hour Data
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/WebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Suite setup       Set Screenshot Directory    ./Screenshots


*** Variables ***

*** Test Cases ***

PMEX-verify that Access Busy Hour Data
    [Tags]  dataIntegrity         pmexClientUI
	Launch the Tibco spotfire PMEX Application
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script      ${test_script}     False
	Click on Report Manager button
	Click on Create
	Verify that Busy Hour is visible in Aggregation    TRUE
	Select Node in Object Aggregation
	Verify that Busy Hour is visible in Aggregation    FALSE
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\PMExBusyHourRMScript.py
	Execute the received iron python script      ${test_script}     False
	Open Data tab and verify the data table
	Verify that the Aggregation is present in the Report title
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\PMExBusyHourRMSaving.py
	Execute the received iron python script      ${test_script}     False
	Select a report and click on edit
	Make changes to report
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\PMExBusyHourEditSaving.py
	Execute the received iron python script      ${test_script}     False
	Verify that the user can View a report
	Verify that the user can delete a report
	Capture page screenshot
	[Teardown]    Close the Tibco spotfire PMEX Application

