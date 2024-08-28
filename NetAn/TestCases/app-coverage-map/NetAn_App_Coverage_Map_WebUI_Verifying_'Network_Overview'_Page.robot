*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEAppCoverageMapKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verifying 'Network Overview' Page
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on button    Network Overview
	verify the page title    Network Overview
	verify DL and UL charts are visible
	verify that the Performance Target dropdowns are visible
	verify that the button is visible    Home
	validate that the button is visible    Historical Trend >>
	[Teardown]    Test teardown
 	
 	