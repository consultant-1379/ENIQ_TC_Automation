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

Verify Detailed data of "Mobility and Accessibility"
	open ran performance wcdma overview analysis
	click on the scroll down button    0    15
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	click on button     Mobility and Accessibility
    verify the page title    Mobility and Accessibility
	Latest ROP and Data Availability should be visible in the top-right portion
    verify KPIs of Mobility and Accessibility
    Then verify data in charts of Mobility and Accessibility
    click on Mobility and Accessibility KPI Details
    verify the page title    Mobility and Accessibility: Details
    Verify detailed data in charts
	[Teardown]    Test teardown
 	
	
*** keywords ***
  
Test teardown steps
    Capture page screenshot
    Close Browser

Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot		