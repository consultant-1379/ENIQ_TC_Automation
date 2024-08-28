*** Settings ***
Library           DatabaseLibrary


Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/CustomKPIManagerClientUI.robot

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
      

*** Test Cases ***
Verify Alarm Generation for Custom KPIs for PDF Counters
    [Tags]        Custom_KPI
    Open Custom KPI Manager Application
	click on Custom KPI Manager button
	verify that the KPI List Page opened up
	click on Import KPIs button
	${KPI}=    write into the CSV file    KPIInformation.csv    PDF_KPI    1000*(DC_E_NR_EVENTS_RPUSERPLANELINK_V_RAW.PMEBSPDCPVOLTRANSDLQOS[32]+DC_E_NR_EVENTS_RPUSERPLANELINK_V_RAW.PMEBSPDCPPKTRECULOOOQOS[78])    NR    TestingKPI    ${EMPTY}    ${EMPTY}    ${EMPTY}
	go to the CSV file location
	open the KPI Template File    1
	verify that the KPI is added
	Close Custom KPI Manager Application
    open pm alarm analysis
    Connect to DB and sync with eniq         NetAn_ODBC
    Click on Alarm rules manager button
    PMAlarmWebUI.Click on Create button
    ${alarm_name}=      Prepare alarm name         Edit
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as      G2RBS01
    Select Measure type as     Custom KPI
    Select measures    ${KPI}
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Congestion
    Enter specific problem     NA         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    PMAlarmWebUI.Verify alarm title      ${alarm_name}
       
    
 

   

    
    


    
    


    