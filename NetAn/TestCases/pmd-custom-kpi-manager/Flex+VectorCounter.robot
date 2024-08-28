*** Settings ***
Force Tags  suite
Documentation     PMA Testcase
Documentation     DB connection
Test Setup        Open Connection And Log In     ${host}     ${username}    ${password}    ${PORT}
Test Teardown     Close All Connections
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
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ./Resources/Keywords/Variables.robot
Resource          ./Resources/Keywords/PMExplorerWebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py

*** Variables ***


*** Test Cases ***

Custom KPI Should not be Created if both Bin and Filter are Incorrectly Entered
	Open Custom KPI Manager
	Click on Load KPIs Button
	Select the CSV file with KPI Details    4
	Verify that KPI is not generated and has errors in Error logs
	Capture page screenshot
	[Teardown]    Close the Custom KPI Manager Application
	
Create a Custom KPI which has support for both Bin and Filter value
	Open Custom KPI Manager
	Click on Load KPIs Button
	Select the CSV file with KPI Details    3
	Verify that FlexFilterValues is added as a column in KPI List page
	Verify that KPI is generated and has no errors in Error logs
	Capture page screenshot
	[Teardown]    Close the Custom KPI Manager Application
			