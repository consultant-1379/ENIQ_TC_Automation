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

MR-EQEV-94962 Verify that NR and LTE Timing Advance is Running
	open NR and LTE Timing Advance analysis
	Go to home page if not already at home
	verify the page title    Home
	Capture page screenshot
	[Teardown]    Test teardown