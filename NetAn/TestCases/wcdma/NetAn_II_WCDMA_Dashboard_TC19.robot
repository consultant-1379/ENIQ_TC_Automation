*** Settings ***
Documentation     Verify Detailed data of Quality of Services KPIs
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

Verify Detailed data of Quality of Services KPIs
    [Tags]       WCDMA_CDB
	open wcdma overview analysis
	Mouse scroller
	Click on the scroll down button    0    15
	click on button    KPI Exploration
	verify the page title    KPI Exploration
	verify that 14 KPIs are available in 3 categories
	click on button     Quality of Service
    verify the page title    Quality of Service
    verify "Latest ROP" and "Data availability" is visible in the top-right portion
    verify KPIs of Quality of Service
    verify data in charts of Quality of Service KPIs
    click button    QoS KPI Details 
    verify the page title    Quality of Service: Details
    verify detailed data in charts of Details Page
	
	
 		
 	