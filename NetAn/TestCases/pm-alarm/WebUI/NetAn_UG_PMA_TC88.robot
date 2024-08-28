*** Settings ***

Documentation     EQEV-110751 - Verify The Message If More Than 4 Measures Are Added During Alarm Creation
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

Verify The Message If More Than 4 Measures Are Added During Alarm Creation
	[Tags]    PMA_CDB     NetAn_UG_PMA_TC88    EQEV-110751
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
    select a node from the list
    Select Measure type as     COUNTER
    Select measures    bfdSessDownCount.DC_E_TCU_BFDSESSIONIPV4_RAW,bfdSessDownDurationMax.DC_E_TCU_BFDSESSIONIPV4_RAW,bfdSessDownDurationMin.DC_E_TCU_BFDSESSIONIPV4_RAW,bfdSessDownDurationTotal.DC_E_TCU_BFDSESSIONIPV4_RAW,bfdSessDroppedPackets.DC_E_TCU_BFDSESSIONIPV4_RAW
    verify that the message 'Max number of measures selected' is visible
    [Teardown]    Test teardown steps for pmalarm