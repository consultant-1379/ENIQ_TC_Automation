*** Settings ***
Documentation     Testing Core Nodetypes
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/WebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py




*** Variables ***
${base_url}=       https://localhost/
${pmex_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Explorer/PM-Explorer/Analyses/PM%20Explorer&waid=Tza-om0C4Emhp9dxoJ0wu-091024061e335T&wavid=0
${browser_name}=   chrome

*** Test Cases ***

Verify that PMex: Script changes for Admin page to support Multi-ENIQ
	Launch the Tibco spotfire PMEX Application
	${test_script}=    Get iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script     ${test_script}     False
	Go to Administration Page
	Verify that the following text is visible    Please enter ENIQ names separated with ",
	Verify that the connection is successful
	Verify that new data sources are visible in ENIQ DataSources table
	Delete button should be visible
	Select a data source from ENIQ DataSources table
	${test_script1}=    Get iron_python script by passing project location for multi eniq    ${scripts}\\deleteDataSource.py
	Execute the iron python script for multi eniq     ${test_script1}     False
	Verify that the selected data source has been deleted
	Capture page screenshot
	[Teardown]    Close the Tibco spotfire PMEX Application
	
