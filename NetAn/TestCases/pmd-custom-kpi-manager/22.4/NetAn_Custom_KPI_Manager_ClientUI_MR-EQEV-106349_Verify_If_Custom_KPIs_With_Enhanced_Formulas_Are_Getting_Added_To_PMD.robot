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
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/CustomKPIManagerClientUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMExplorerWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite Setup       Suite setup steps

*** Test Cases ***

Verify If Custom KPIs Wioth Enhanced Formulas Are Getting Added to PMD
	Open the Custom KPI Manager Application
	click on the Custom KPI Manager button
	verify that KPI List Page opened up
	click on Import KPIs button
	${KPI}=    write into the CSV file    KPIInformation.csv    EnhancedKPI    100*(DC_E_NR_EVENTS_NRCELLCU_V_RAW.PMEBSSESSIONTIMEDRB5QI[10]+DC_E_NR_EVENTS_NRCELLCU_V_RAW.PMEBSRRCCONNESTABLATDISTR[89])    NR    TestingKPI      ${EMPTY}      ${EMPTY}    ${EMPTY}
	go to the CSV file location
	open the KPI Template File    1
	verify that the KPI is added
	Close Custom KPI Manager Application
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots