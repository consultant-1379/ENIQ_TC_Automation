*** Settings ***
Documentation       Check If 'Hour Of Day Filter' Is A Check box Filter
Library           DatabaseLibrary
Library           AutoItLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Check If 'Hour Of Day Filter' Is A Check box Filter
    [Tags]      PMEX_CDB    Report_Manager       NetAn_UG_PMEX_TC83
	open pm explorer analysis
	Click on Report manager button 
	validate the page title    Report Manager
    Click on Create button
    Sleep    5s
    validate the page title    Measure Selection
    Click on scroll down button    7    25
    validate that the Hour of Day filter is a check box filter
    Capture page screenshot
    
