*** Settings ***

Documentation     Validate Alarm Generation For 'Multitable KPI + Counter' Combination In Alarm Rule Manager Page
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

Validate The 'Measure Type': 'Multitable KPI + Counter' Combination List In Alarm Rule Manager Page
    [Tags]    PMA_CDB    NetAn_UG_PMA_TC21
	open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm_
    Select the alarm type     Past Comparison Detection + Continuous Detection
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       RBS
    Click on fetch nodes button
    Select Nodes as    RNC1RBS1
    Select Measure type as     KPI
    Select measures          PacketintHs_U_Resource
    Select Measure type as     Counter,FLEX_COUNTER
    Select measures    pmCapacityHsDschUsers.DC_E_RBS_HSDSCHRES_V_RAW,pmDelayDistributionSpi05.DC_E_RBS_HSDSCHRES_V_RAW
	Select Alarm severity as      Critical
    Select Aggregation as      1 Day
	Enter Look back period    3
	Select Look back period unit as    Day(s)
	Enter Date range    8
	Select Date range unit as    Hour(s)
    Select Probable cause as       Reduced alarm reporting
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