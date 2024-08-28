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

Verify If A KPI Is Being Used During Deletion
	Open the Custom KPI Manager Application
	click on the Custom KPI Manager button
	verify that KPI List Page opened up
	click on Import KPIs button
	${KPI}=    write into the CSV file    DeleteKPIInformation.csv    deleteKPI    DC_E_NR_EVENTS_NRCELLCU_FLEX_RAW.pmEbsRwrEutranUeSuccEpsfbMeasTo    NR    TestingKPI      ${EMPTY}      endc0To1    ${EMPTY}
	go to the CSV file location
	open the KPI Template File    2
	verify that the KPI is added
	Close Custom KPI Manager Application
	open pm explorer analysis
	Connect to DB and sync with eniq
	PMExplorerWebUI.Click on Report manager button
    PMExplorerWebUI.Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    G2RBS01
    Select the Aggregation    No Aggregation
    Select the measure type    CUSTOM_KPI
    Select KPIs    ${KPI}
    Select time drop down to      Last 30 Days    
    Select Aggregation in select time as     Day
    click on button    Fetch PM Data
    sleep    10
    click on button    Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save Report to Library
	Open the Custom KPI Manager Application
	click on the Custom KPI Manager button
	verify that KPI List Page opened up
	click on Import KPIs button
	${KPI}=    write into the CSV file    DeleteKPIInformation.csv    deleteKPI    DC_E_NR_EVENTS_NRCELLCU_FLEX_RAW.pmEbsRwrEutranUeSuccEpsfbMeasTo    NR    TestingKPI      ${EMPTY}      endc0To1    ${EMPTY}
	go to the CSV file location
	open the KPI Template File    2
	verify that the KPI is added
	click on the delete button
	verify that deletion failed since KPIs are being used
	Close Custom KPI Manager Application
    Capture page screenshot
	[Teardown]    Test teardown
	
	
*** Keywords ***  

Suite setup steps
    Set Screenshot Directory   ./Screenshots