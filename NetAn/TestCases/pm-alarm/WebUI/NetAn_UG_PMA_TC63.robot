*** Settings ***

Documentation     EQEV-103724 - Validate The Alarm Information Column In Alarm Rules Manager Page
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

Validate The Alarm Information Column In Alarm Rules Manager Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC63    EQEV-103724
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
	verify that alarm name field is empty
	verify that the specific problem textarea is empty
	verify that the alarm type dropdown is empty by default
	verify that the node/collection/subnetwork dropdown is empty by default
    validate that the dropdown Alarm Severity is working as expected
    validate that the dropdown Aggregation is working as expected
    validate that the dropdown Probable Cause is working as expected
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