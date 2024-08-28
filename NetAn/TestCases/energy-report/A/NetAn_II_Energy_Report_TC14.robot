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
 
Verify Energy Saving Features - Features State Functionality
	[Tags]     Energy_Report_KGB    Energy_Report_CDB    
	click on Reset All Filters and Markings button
	click on button    Energy Saving Features
	verify the page title    Energy Saving Features
	select a RAT
	select an Energy Saving Feature
	select an area on the Feature Chart
	verify that the marked value is not 0
	capture page screenshot