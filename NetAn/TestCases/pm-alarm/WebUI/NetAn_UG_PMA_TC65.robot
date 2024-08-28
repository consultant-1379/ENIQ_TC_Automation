*** Settings ***

Documentation     EQEV-103724 - Validate The Error Message If We Try Alarm Creation With Measures From Different Tables
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

Validate The Error Message If We Try Alarm Creation With Measures From Different Tables
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC65    EQEV-103724
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Alarm
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    Select Nodes as    ERBS1
    Select Measure type as     COUNTER
    Select measures    espTunInInvalidSpi.DC_E_TCU_IPSECTUNNEL_RAW,aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    validate that the Measure error is present
    [Teardown]    Test teardown steps for pmalarm