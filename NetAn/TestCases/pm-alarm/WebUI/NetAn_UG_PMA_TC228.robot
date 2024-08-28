*** Settings ***

Documentation    MR-EQEV-110783 Validate Alarm creation for PDF+Flex counter as All
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***
Validate Alarm creation for PDF+Flex counter as All
    [Tags]        EQEV-110783    NetAn_UG_PMA_TC228      PMA_CDB
    open pm alarm analysis
    Click on Alarm rules manager button
    click on scroll down button    0    20
    Click on Create button
    ${alarm_name}=      Prepare alarm name         FLEXPDF
    Select the alarm type     Dynamic Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
	Select measures    pmEbsPdcpVolUlHdrProf2Rohc5qi.DC_E_NR_EVENTS_RPUSERPLANELINK_V_RAW
    Select Alarm severity as      Minor
	Select Aggregation as      None
	Enter Date range    25
	Select Date range unit as    Day(s)
    Select Probable cause as       Threshold Crossed
    Enter specific problem     NA      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    Click on Save button 
	Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
