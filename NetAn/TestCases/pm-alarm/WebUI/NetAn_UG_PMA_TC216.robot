*** Settings ***

Documentation     Validate if Availble Measures are displayed based on Measures Type check boxes selection
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           SSHLibrary
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMAlarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/CustomKPIManagerClientUI.robot

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***
 Validate if Availble Measures are displayed based on Measures Type check boxes selection
    [Tags]       PMA_CDB       Alarm_Rules_Manager      EQEV-119128
    open pm alarm analysis
    Click on Alarm rules manager button
    click on scroll down button    0    20
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Moclass
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button in Alarm rules manager
    Select Nodes as     ERBS1 
    #click on scroll down button    0    20
    Select MOClass as    EUtranCellFDD
    Select the measure type   KPI
    Click on scroll down button    5     12
    Verify the measures    Average DL MAC Cell Throughput
    Capture page screenshot
	