
*** Settings ***
Documentation     Node Troubleshooting verification of Band Frequency and Channel Bandwidth
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
*** Test Cases ***
Node Troubleshooting Verification Band Frequency and Channel Bandwdth
    [Tags]        Ran_Uplink_Interference_CDB         Ran_Uplink_Interference_KGB      EQEV-141380
	open uplink interference analysis
	Go to home page if not already at Home
	Click on node troubleshooting button
	select node for filtered data    ERBSG201
	Click on fetch data button
	verify that Cell/Branch drop down is visible and select Cell
	verify that Band and frequency has some values in node trouble shooting
	verify that Channel Bandwidth has some values in node trouble shooting
	capture page screenshot
 	