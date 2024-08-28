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

Verify Functionality of Settings Page
	[Tags]     Energy_Report_KGB    Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on the button    Settings
	verify the page title    Settings
	Enter the number of data sources    1
	Enter the data source    NetAn_ODBC
	click on button value    Configure MSA
	Verify that the data source is added
	click on the scroll down button    0    36
	click on the button    Home
	verify the page title    Home