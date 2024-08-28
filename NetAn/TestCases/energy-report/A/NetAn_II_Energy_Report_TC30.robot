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

Verify Energy Saving Features - Installed State In Feature Column and Active State In Service Column Functionality
	[Tags]     Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on button    Energy Saving Features
	verify the page title    Energy Saving Features
	select a RAT
	select an Energy Saving Feature
	select an area on the License Chart
	select installed in energy saving feature license table
	select active in energy saving feature license table
    capture page screenshot