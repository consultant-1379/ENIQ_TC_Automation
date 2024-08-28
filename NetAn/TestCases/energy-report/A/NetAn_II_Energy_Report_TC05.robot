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

Verify Network Summary - Software Overview - Throughput Functionality - chart 'Uplink volume, downlink volume per date'
    [Tags]     Energy_Report_CDB    EQEV-115772
	click on Reset All Filters and Markings button
	Click on Network Summary button 
	verify the page title    Network Summary - (Up to 6 Months)
	Click on Software Overview >> button
	verify the page title    Software Overview - Energy Consumption (6 Months)
	Selection in Software Type(s) list box
	Verify that 'Node count per software version' chart is visible
	Make selection on Node count per software version chart
	Verify that 'Uplink volume, downlink volume per date' chart is visible on Software Overview page
	








