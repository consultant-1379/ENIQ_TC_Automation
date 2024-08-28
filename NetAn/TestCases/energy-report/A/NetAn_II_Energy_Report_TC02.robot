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

Verify Hardware And Software Overview Functionality-Chart 'Consumed Energy Per Node Per Hardware'
    [Tags]     Energy_Report_CDB    EQEV-115772
	Click on Reset All Filters and Markings button
	Click on Energy Usage button
	verify the page title   Energy Usage (7 Days)
	click on the scroll down button    4    15
	select a RAT
	make selection on Top 100 Nodes with Highest Energy Consumption chart
    Click on Hardware and Software Overview >> button
	verify the page title    Hardware and Software Overview - Energy Consumption (7 Days)
	Selection in Select Hardware Type(s) list box
	Verify that 'Consumed energy per software version' chart is visible