*** Settings ***
Documentation     Health Check verification of Band Frequency and Channel Bandwidth
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Node Troubleshooting Verification Band Frequency and Channel Bandwdth
    [Tags]        Ran_Uplink_Interference_CDB         Ran_Uplink_Interference_KGB      EQEV-141380
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	All input panels should be present
	click on the scroll down button    2    10
	verify that Cell/Branch drop down is visible and select Cell
	verify that Band and frequency has some values
	verify that Channel Bandwidth has some values
	capture page screenshot
	[Teardown]    Test teardown
 	
 	