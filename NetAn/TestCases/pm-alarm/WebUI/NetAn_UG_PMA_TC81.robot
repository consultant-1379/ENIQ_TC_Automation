*** Settings ***
Documentation     EQEV-110751_Validate The Error Message If We Try Alarm Creation With Counters From Different Tables
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
      

*** Test Cases ***

Validate The Error Message If We Try Alarm Creation With Counters From Different Tables
    [Tags]    PMA_CDB     NetAn_UG_PMA_TC81    EQEV-110751
    open pm alarm analysis
    click on scroll down button    0    20    
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Alarm
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    select a node from the list
    Select Measure type as     COUNTER
    Select measures    espTunInInvalidSpi.DC_E_TCU_IPSECTUNNEL_RAW,aclTotalDiscards.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Enter the specific problem
    Click on scroll down button    5    40    
    validate that the Measure error is present