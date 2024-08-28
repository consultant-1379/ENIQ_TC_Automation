*** Settings ***
Force Tags  suite
Documentation      Verify that data is displayed for the created Custom KPI

Suite setup       Set Screenshot Directory   ./Screenshots
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
																								   
										

*** Variables ***


*** Test Cases ***

Verify that data is displayed for the created Custom KPI
    [Tags]          pmexClientUI
	Launch the Tibco spotfire PMEX Application
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script      ${test_script}     False
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\PMExPDFandFlexCounter.py
	Execute the received iron python script      ${test_script}     False
    [Teardown]     Close Tibco spotfire PMEX Application
