*** Settings ***
Documentation     PMEX-Verify Update Selection of Logic Combinations
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

PMEX-Verify Update Selection of Logic Combinations
    [Tags]          pmexClientUI
	Launch the Tibco spotfire PMEX Application
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script      ${test_script}     False
	Click on Report Manager button
	Click on Create
	Verify that Preceding Period is selected in Time Period
	Make selection in Aggregation    BusyHour
	Verify the range for    BusyHour
	Make selection in Aggregation    Day
	Verify the range for    Day
	Make selection in Aggregation    Hour
	Verify the range for    Hour
	Make selection in Aggregation    Month
	Verify the range for    Month
	Make selection in Aggregation    ROP
	Verify the range for    ROP
	Make selection in Aggregation    Week
	Verify the range for    Week
	Capture page screenshot
	[Teardown]    Close the Tibco spotfire PMEX Application
		
