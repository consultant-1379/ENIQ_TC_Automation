*** Settings ***
Documentation     Verifying "KPI Exploration" button
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${WCDMAKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot


*** Test Cases ***

Verifying KPI Exploration button
    [Tags]    WCDMA_CDB
	open wcdma overview analysis
	Mouse scroller
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	verify that the button is present    Home
	verify that the button is present    Settings
	verify that the button is visible	 Quality of Service
	verify that the button is visible	 Utilization
	verify that the button is visible	 Mobility and Accessibility
	click on the button      Home
	verify the page title	 Start
	Mouse scroller
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	click on the button     Settings
	verify the page title    Settings
	click on the button      Home
	Mouse scroller
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	click on button     Quality of Service
    verify the page title    Quality of Service
    click on button    Previous page
    click on button     Utilization
    verify the page title    Utilization
    click button    Previous page
    