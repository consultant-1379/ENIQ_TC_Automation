*** Settings ***
Documentation      Validate 'Hour Of Day' Is Present In 'Advanced Options'
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

Validate 'Hour Of Day' Is Present In 'Advanced Options'
    [Tags]     Report_Manager    PMEX_CDB         NetAn_UG_PMEX_TC89
	open pm explorer analysis
	Click on Report manager button 
	validate the page title    Report Manager
    click on Create button
    validate the page title    Measure Selection
    Click on scroll down button    7    15
    validate that the section is present    Day of week filtering
    validate that the section is present    Hour of day filtering
    Capture page screenshot
   
