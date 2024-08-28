*** Settings ***
Force Tags  suite
Documentation     Create a Custom KPI which has support for both Bin and Filter value

Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library          SSHLibrary
Library          DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
																								   
										

*** Variables ***


*** Test Cases ***
	
Create a Custom KPI which has support for both Bin and Filter value
    [Tags]        pmexClientUI
	Open Custom KPI Manager
	Click on Load KPIs Button
	Select the CSV file with KPI Details    1
	Verify that FlexFilterValues is added as a column in KPI List page
	Verify that KPI is generated and has no errors in Error logs
	Capture page screenshot
	[Teardown]     Test teardown steps
	
*** Keywords ***   
	
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
