*** Settings ***

Documentation     EQEV-106349 - Verify Alarm Generation for Custom KPIs for PDF+Flex Counters
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

Verify Alarm Generation for Custom KPIs for PDF+Flex Counters
    [Tags]    PMA_CDB    NetAn_UG_PMA_TC58    EQEV-106349
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         CustomKPI_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as      G2RBS01
    Select Measure type as     CUSTOM_KPI
    Select measures    Flex_PDF_Counter
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Congestion
    Enter specific problem     NA         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    Click on Save button
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
	[Teardown]    Test teardown steps for pmalarm