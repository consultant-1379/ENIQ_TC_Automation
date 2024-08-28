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

After Deletion Of KPI Verify The Pop-Up 'KPIs Deleted Successfully'
	Open the Custom KPI Manager Application
	click on the Custom KPI Manager button
	verify that KPI List Page opened up
	click on Import KPIs button
	${KPI}=    write into the CSV file    DeleteKPIInformation.csv    deleteKPI    DC_E_NR_EVENTS_NRCELLCU_FLEX_RAW.pmEbsRwrEutranUeSuccEpsfbMeasTo    NR    TestingKPI      ${EMPTY}      endc0To1    ${EMPTY}
	go to the CSV file location
	open the KPI Template File    2
	verify that the KPI is added
	delete the KPI
	verify the pop-up message KPIs Deleted Successfully
	verify that the KPI is not present in Custom KPIs table
	Capture page screenshot
	[Teardown]    Close Custom KPI Manager Application
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots
    
Test teardown
	Capture page screenshot
    Close Browser