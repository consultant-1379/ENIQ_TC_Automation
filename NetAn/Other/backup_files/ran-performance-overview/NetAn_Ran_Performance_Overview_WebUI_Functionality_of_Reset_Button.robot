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

Verify Functionality of Reset Button
	open ran performance lte overview analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Worst Performing Nodes
	verify the page title    Worst Performing Nodes
	make selection in worst performing nodes
	${markedValue}=    read the marked value
	click on the button    Return to Home
	click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings
	click on button    Worst Performing Nodes
	verify that the marked value is not equal to    ${markedValue}
 	[Teardown]    Test teardown
 	
 	