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

Verify Energy Saving Features - Node Details - 2 Years History Visuals
	[Tags]     Energy_Report_CDB
	click on Reset All Filters and Markings button
	click on button    Energy Saving Features
	verify the page title    Energy Saving Features
	select an area on the License Chart									
	click on button    Node Detail >>
	sleep    60
    verify the page title    Node Details
    verify that the list box is visible    Node(s)
    verify that the list box is visible    Energy saving feature
    verify that the list box is visible    Dates
    click on the scroll down button    8    20
    verify that the list box is visible    Threshold feature
    verify that the table is visible    Energy saving feature license, feature and service state
    verify the graph title is present    Energy saving feature thresholds 
    verify the graph title is present    License state over time
    verify the graph title is present    Feature state over time
    verify the graph title is present    Service state over time
    verify that the button is visible    Home
    validate that the button is visible    << Energy Saving Features
	capture page screenshot
	