*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/RanPerformanceOverviewWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps

*** Test Cases ***

Verifying "KPI Exploration" button
	open ran performance wcdma overview analysis
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
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	click on the button     Settings
	verify the page title    Settings
	click on the button      Home
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	click on button     Quality of Service
    verify the page title    Quality of Service
    click on button    Previous page
    click on button     Utilization
    verify the page title    Utilization
    click button    Previous page
    [Teardown]    Test teardown

*** keywords ***    
    
Test teardown steps
    Capture page screenshot
    Close Browser

Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot	 	
 	