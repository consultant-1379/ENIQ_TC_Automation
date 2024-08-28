*** Settings ***

Documentation     Validate Alarm Generation For 'Multitable KPI + Counters From Union Tables' Combination In Alarm Rule Manager Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate The 'Measure Type': 'Multitable KPI + Counters From Union Tables' Combination List In Alarm Rule Manager Page
	[Tags]    PMA_CDB        NetAn_UG_PMA_TC22
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     MultiTable_KPI_Counters_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    Select Nodes as    ERBS1
    Select Measure type as     KPI
    Select measures          Average DL PDCP UE Throughput
    Select Measure type as     Counter
    Select measures          pmCellDowntimeAuto.DC_E_ERBS_EUTRANCELLFDD_RAW,pmCellDowntimeMan.DC_E_ERBS_EUTRANCELLFDD_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     NA      ${alarm_name}
    Enter alarm name     ${alarm_name}
	Click on scroll down button    5     10 
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    Verify columns displayed    DC_TIMEZONE
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active