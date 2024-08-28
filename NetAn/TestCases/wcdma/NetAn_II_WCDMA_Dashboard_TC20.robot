*** Settings ***
Documentation     Verify Detailed data of Service Utilization KPIs
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

Verify Detailed data of Service Utilization KPIs
    [Tags]       WCDMA_CDB
	open wcdma overview analysis
	Mouse scroller
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	click on button     Utilization
    verify the page title    Utilization
    verify "Latest ROP" and "Data availability" is visible in the top-right portion
    verify KPIs of Service Utilization
    verify data in charts of Utilization
    click on button    Utilization KPI Details
    verify the page title    Utilization: Details
    verify detailed data in charts of Details Page
	