*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/NR-LTETimingAdvanceWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

MR-EQEV-94962 Verification NR Map View Page
	open NR and LTE Timing Advance analysis
	Go to home page if not already at home
	click on the button    Reset Filters
	verify the page title    Home
	validate that the button is visible    NR Overview 
	validate that the button is visible    LTE Overview
	verify that the button is visible    Reset Filters
	click on button    NR Overview
	verify the page title    NR TA Overview
	select the nodes    G2RBS_01
	click on button    NR Map View >>
	verify the page title    NR Map View
	select the subnetwork    NETSimW
	select LTE node    NR02gNodeBRadio00001
	click on button    Refresh
	verify that the rows are not 0
	Capture page screenshot
	[Teardown]    Test teardown