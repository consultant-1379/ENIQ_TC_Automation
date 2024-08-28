*** Settings ***

Documentation    Validate if Available measures values are listed based on MO Class selection
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/CustomKPIManagerClientUI.robot

Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***
Validate if Available measures values are listed based on MO Class selection
    [Tags]       PMA_CDB       Alarm_Rules_Manager      EQEV-119128
    open pm alarm analysis
    Click on Alarm rules manager button
    click on scroll down button    0    20
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Moclass1
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button in Alarm rules manager
    Select Nodes as     ERBS1 
    Select MOClass as    Aal1TpVccTp
    Click on scroll down button    5     12
    Verify the measures    pmLostFpmCells.DC_E_CPP_AAL1TPVCCTP_RAW
    Capture page screenshot