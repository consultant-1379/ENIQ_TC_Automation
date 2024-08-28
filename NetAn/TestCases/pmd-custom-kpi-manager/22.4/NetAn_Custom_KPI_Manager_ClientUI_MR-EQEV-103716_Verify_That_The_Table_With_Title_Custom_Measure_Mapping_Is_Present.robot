*** Settings ***
Library           DatabaseLibrary
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/CustomKPIManagerClientUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Suite Setup       Suite setup steps

*** Test Cases ***

Verify That The Table With Title Custom Measure Mapping Is Present
	Open Custom KPI Manager Application
	click on Custom KPI Manager button
	verify that the KPI List Page opened up
	verify that the table Error Log is visible
	open the Custom Measure Mapping file
	verify that the table Custom Measure Mapping table is present
	Capture page screenshot
	[Teardown]    Close Custom KPI Manager Application
	
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots