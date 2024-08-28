*** Settings ***

Documentation     MR-EQEV-110783 Verify Alarm creation for PDF counter as all
Library           DatabaseLibrary
Library           AutoItLibrary
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
Verify Alarm creation for PDF counter as all 
    [Tags]        EQEV-110783    NetAn_UG_PMA_TC224          PMA_CDB
    open pm alarm analysis
    Click on Alarm rules manager button
    click on scroll down button    0    20
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Flex
    Select the alarm type     Dynamic Threshold
    Select ENIQ Data Source as    NetAn_ODBC 
    Select Single Node or Collection or Subnetwork    Single Node
    Select System area as   Radio
    Select Node type as    NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
    Select measures    pmDrbEstabAtt5qi.DC_E_NR_NRCELLCU_V_RAW
	Select PDF value from dropdown    All
    Click on apply PDF setting button
	Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem    NA      
    Enter alarm name     ${alarm_name}
	Click on scroll down button    5     10 
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
	${alarm_criteria}=     Verify alarm criteria
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active