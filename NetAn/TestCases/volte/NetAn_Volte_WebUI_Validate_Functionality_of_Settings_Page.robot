*** Settings ***
Documentation     Dataintegrity testcase
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/VoLTEWebUI.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Set Screenshot Directory    ./Screenshots

***Test Cases***

Validate Functionality of Settings Page
    open volte analysis
	Go to home page if not already at home
	click on VoLTE Reset button
    click on button title    Settings
    validate page title as    Settings
    #Selecting the SBG and MOID      ISSBG01         SubNetwork=IsNetwork,IsSite=ISSBG01
    click on button value    Save
    click on the scroll down button    2    12
    #Selected MOID should come under relevant NetId        ISSBG01         SubNetwork=IsNetwork,IsSite=ISSBG01
    click on button value    Clear All
    Relevant section should be empty
    Capture page screenshot
    [Teardown]    Test teardown