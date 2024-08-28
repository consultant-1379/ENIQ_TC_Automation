*** Settings ***

Documentation     Validate Functionality of Services Comparison Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           SikuliLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/VoLTEWebUI.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Set Screenshot Directory    ./Screenshots

***Test Cases***

Validate Functionality of Services Comparison Page
    open volte analysis
	click on Home button if not in volte home page
	Click on the scroll down button    0    20
	click on VoLTE Reset button
    click on button title    Services Comparison
    validate page title as    Service Comparison
    Verifying the headings of charts
    Making selection on graph    E-RAB Retainability Abnormal Releases
    Checking marked value
    click on button title    Home
    click on VoLTE Reset button
    click on button title    Services Comparison
    validate page title as    Service Comparison
    Marked value should be 0
    Capture page screenshot
    [Teardown]    Test teardown