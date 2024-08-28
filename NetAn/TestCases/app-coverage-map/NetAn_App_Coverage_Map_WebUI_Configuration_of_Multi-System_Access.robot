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

Configuration of Multi-System Access
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on the button    Settings
	verify the page title    Settings
	Click on the scroll down button    0    30
	open MSA Configurations
	enter the number of data sources    1
	enter the data source    IncorrectName
	Click on the scroll down button    0    10
	click on button    Configure MSA
	Click on the scroll down button    0    10
	verify that the connection is not made
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	