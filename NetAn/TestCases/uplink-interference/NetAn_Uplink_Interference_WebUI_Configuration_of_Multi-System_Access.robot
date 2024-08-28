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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Configuration of Multi-System Access
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on the button    Settings
	verify the page title    Settings
	enter the number of data sources    1
	enter the data source    IncorrectName
	click on button    Configure MSA
	click on the scroll down button    0    25
	verify that the connection is not made
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	