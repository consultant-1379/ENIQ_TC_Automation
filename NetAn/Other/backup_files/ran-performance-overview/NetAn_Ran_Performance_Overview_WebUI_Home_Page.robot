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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/RanPerformanceOverviewWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify Home Page
	open ran performance lte overview analysis
	Go to home page if not already at home
	verify that the Network Analytics logo is visible
	verify that the Ran Performance Overview logo is visible
	click on the scroll down button    0    15
	verify that the reset button is visible
	verify that the button is visible    Worst Performing Nodes
	verify that the button is visible    Node Information
	click on button    Worst Performing Nodes
	verify the page title    Worst Performing Nodes
	make selection in worst performing nodes
	${markedValue}=    read the marked value
	click on the button    Return to Home
	click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings
	click on button    Worst Performing Nodes
	verify that the marked value is not equal to    ${markedValue}
	click on the button    Return to Home
	click on the scroll down button    0    15
	click on button    Node Information
	verify the page title    Node Information
	click on the button    Return to Home
 	[Teardown]    Test teardown
 	
 	