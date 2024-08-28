*** Settings ***

Library           SikuliLibrary
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

Validate Functionality of VoLTE Monitor Page
    open volte analysis
	Go to home page if not already at home
	click on the scroll down button    0    20
	click on VoLTE Reset button
    click on button title    VoLTE Monitor
    validate page title as    VoLTE Monitor
    click on button value    Node Troubleshooting >>
    validate page title as    Node Troubleshooting
    Make selections in the KPI
    click on button value    Daily Breakdown >>
    validate page title as    Daily Breakdown
    select the days for comparison
    click on button value    Filtered Data >>
    validate page title as    Filtered Data
    first 10 columns should have data
    Capture page screenshot
    [Teardown]    Test teardown