*** Settings ***
Force Tags  suite
Documentation     Custom KPI Should not be Created if the Bin or Flex-filter are Incorrectly Entered

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

Custom KPI Should not be Created if the Bin or Flex-filter are Incorrectly Entered
    [Tags]  dataIntegrity         pmexClientUI
	Open Custom KPI Manager
	Click on Load KPIs Button
	Select the CSV file with KPI Details    2
	Verify that FlexFilterValues is added as a column in KPI List page
	Verify that KPI is not generated and has errors in Error logs
	Capture page screenshot
	[Teardown]    Close the Tibco spotfire PMEX Application
	
