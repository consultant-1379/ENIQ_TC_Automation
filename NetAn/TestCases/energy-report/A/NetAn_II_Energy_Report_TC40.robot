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

Verify Network Summary - Software Overview Functionality - chart 'Node count per software version'
    [Tags]     Energy_Report_CDB    EQEV-115772
	Click on Reset All Filters and Markings button
	Click on Network Summary button 
	verify the page title    Network Summary - (Up to 6 Months)
	Click on Software Overview >> button
	verify the page title    Software Overview - Energy Consumption (6 Months)
	Selection in Software Type(s) list box
	Verify that 'Node count per software version' chart is visible