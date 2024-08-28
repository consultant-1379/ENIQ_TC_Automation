*** Settings ***

Documentation     MR-EQEV-110783 Validate if the measures are in different table and tries to add measure.
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
Validate if the measures are in different table and tries to add measure.
    [Tags]        EQEV-110783    NetAn_UG_PMA_TC231            PMA_CDB
    open pm alarm analysis
    Click on Alarm rules manager button
    click on scroll down button    0    20
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Moclass
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
	Select measures    delayRtP95.DC_E_TCU_TWAMP_TEST_SESSION_V_RAW,pmEbsMacUeHarqUlDtxQpsk.DC_E_NR_EVENTS_NRCELLDU_FLEX_RAW
	validate Measure error message  
    

	