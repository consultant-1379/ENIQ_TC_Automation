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
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Verify Home Page
	[Tags]     Energy_Report_KGB    Energy_Report_CDB
	verify that the Network Analytics logo is visible
	verify that the Energy Report logo is visible										  											  
	Click on Reset All Filters and Markings button
	click on the button    Settings
	verify the page title    Settings
	click on the scroll down button    0    36
	click on the button    Home	
	verify the page title    Home
	verify that the Settings and Reset icons are visible
	