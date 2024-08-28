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

Check If Pop-up Message "Duplication Of KPIs" Is Visible If KPI Already Exists
	Open Custom KPI Manager Application
	click on Custom KPI Manager button
	verify that the KPI List Page opened up
	click on Import KPIs button
	go to the CSV file location
	select CSV file with KPI details    1
	verify that the KPI is added
	click on Import KPIs button
	go to the CSV file location
	select CSV file with KPI details    1
	verify that 'Duplication Of KPIs' pop-up is visible
	Capture page screenshot
	[Teardown]    Close Custom KPI Manager Application
	
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots