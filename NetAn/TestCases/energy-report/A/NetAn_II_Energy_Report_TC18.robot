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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Verify Energy Saving Features - Node Details - 2 Years History Functionality
    [Tags]     Energy_Report_KGB     Energy_Report_CDB       s14
	click on Reset All Filters and Markings button
	click on button    Energy Saving Features
	verify the page title    Energy Saving Features
	select a RAT
	select an Energy Saving Feature
	select an area on the License Chart									
	click on button    Node Detail >>
	verify the page title    Node Details
    sleep    60
	select Node(s)
    click on the scroll down button    8    20
	select data in energy saving feature license table
	verify that the marked value is not 0
	select data in energy saving feature Threshold table
	verify that the marked value is not 0
    verify that the button is visible    Home
    validate that the button is visible    << Energy Saving Features
    capture page screenshot
	