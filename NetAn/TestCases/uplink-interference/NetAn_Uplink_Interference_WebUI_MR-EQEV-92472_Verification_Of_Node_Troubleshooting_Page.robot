*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verification Of Node Troubleshooting Page
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Node Troubleshooting
	verify the page title    Node Troubleshooting
	${node}=    select eNodeB and click on Fetch Data
	verify that Node Troubleshooting Page for the selected node is visible    ${node}
	verify that Cell/Branch drop down has Cell and Branch and select Cell
	verify that the check box 'Band and Frequency' is visible
	verify that the check box 'Channel Bandwidth' is visible
	verify that all navigation buttons on Node Troubleshooting Page are working properly
	[Teardown]    Test teardown
 	
 	