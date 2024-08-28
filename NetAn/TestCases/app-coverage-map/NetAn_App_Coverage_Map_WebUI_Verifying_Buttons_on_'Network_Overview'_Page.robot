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

Verifying Buttons on 'Network Overview' Page
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on button    Network Overview
	verify the page title    Network Overview
	verify that the button is visible    Home
	validate that the button is visible    Historical Trend >>
	click on button    Historical Trend >>
	verify the page title    Historical Trend - Network Overview
	click on button    << Network Overview
	verify the page title    Network Overview
	click on the button    Home
	Verify the page title    Home
	[Teardown]    Test teardown
 	
 	