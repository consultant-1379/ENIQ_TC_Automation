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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

Suite Setup       Suite setup steps
*** Test Cases ***

Verify 'Generate KPI Template' Button on Custom KPI Manager Home Page
	Open Custom KPI Manager Application
	click on Custom KPI Manager button
	verify that the KPI List Page opened up
	click on Generate KPI Template button
	verify that the Generate KPI Template button is working
	Capture page screenshot
	[Teardown]    Close the Tibco spotfire PMEX Application
	
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots