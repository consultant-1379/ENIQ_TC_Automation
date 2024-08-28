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

Verify Historical Trend Functionality Of All Panels
	[Tags]    Energy_Report_CDB     Energy_Report_KGB
	Click on Reset All Filters and Markings button
	click on button value    Energy Usage
	verify the page title   Energy Usage (7 Days)
	click on the scroll down button    4    10
	select a RAT
	make selection on Top 100 Nodes with Highest Energy Consumption chart
	click on button value    Historical Trend >>
	verify the page title    Historical Trend
	verify that four historical trend visual panels are visible