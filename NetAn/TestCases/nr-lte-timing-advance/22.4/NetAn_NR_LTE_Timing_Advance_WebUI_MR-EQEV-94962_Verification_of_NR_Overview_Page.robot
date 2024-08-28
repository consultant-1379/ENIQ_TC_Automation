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

MR-EQEV-94962 Verification NR Overview Page
	open NR and LTE Timing Advance analysis
	Go to home page if not already at home
	verify the page title    Home
	validate that the button is visible    NR Overview 
	validate that the button is visible    LTE Overview
	verify that the button is visible    Reset Filters
	click on button    NR Overview
	verify the page title    NR TA Overview
	verify that the button is visible    Home
	validate that the button is visible    NR Map View >>
	verify that the chart is visible    NR Timing Advance Overview (last 7 Days)
	Capture page screenshot
	[Teardown]    Test teardown