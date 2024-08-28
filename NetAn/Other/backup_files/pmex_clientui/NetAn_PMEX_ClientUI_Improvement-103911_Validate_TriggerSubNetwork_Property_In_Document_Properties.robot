*** Settings ***
Library           DatabaseLibrary
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMExplorerWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite Setup       Suite setup steps

*** Test Cases ***

Validate TriggerSubNetwork Property In Document Properties
	[Tags]          pmexClientUI 
	Launch the Tibco spotfire PMEx Application
	open the Properties tab in Document Properties
	scroll down to TriggerSubNetwork Property
	read the TriggerSubNetwork timestamp
	Capture page screenshot
	[Teardown]    Close Tibco spotfire PMEX Application
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots