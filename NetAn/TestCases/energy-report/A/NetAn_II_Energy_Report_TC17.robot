*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Verify Energy Saving Features - Network Summary Latest Configuration Status Visuals
	[Tags]     Energy_Report_CDB
	click on Reset All Filters and Markings button
	click on button    Energy Saving Features
	verify the page title    Energy Saving Features
	verify the graph title is present    License state - 
	verify the graph title is present    Feature state - 
	verify the graph title is present    Service state - 
	verify that the table is visible    Energy saving feature license, feature and service state
	verify that the table Energy Saving Feature Thresholds is visible   
	verify that the list box is visible    RAT(s)
	verify that the list box is visible    Energy saving feature
	click on the scroll down button    0    15	
	click on the button    Home
	verify the page title    Home
	click on button    Energy Saving Features
	verify the page title    Energy Saving Features
	click on button    Node Detail >>
	capture page screenshot
