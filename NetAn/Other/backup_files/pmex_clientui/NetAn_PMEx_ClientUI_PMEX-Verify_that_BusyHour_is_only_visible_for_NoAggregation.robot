*** Settings ***
Documentation     PMEX-Verify that BusyHour is only visible for NoAggregation
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
	
PMEX-Verify that BusyHour is only visible for NoAggregation
    [Tags]           pmexClientUI
	Launch the Tibco spotfire PMEx Application
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script      ${test_script}     False
	Click on Report Manager button
	Click on Create
	Verify that BusyHour is only visible for No aggregation
	Capture page screenshot
	[Teardown]    Close the Tibco spotfire PMEX Application
	
	
	
	
	
	
