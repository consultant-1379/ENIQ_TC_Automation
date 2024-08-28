*** Settings ***
Library           Validate That 'Day Of Week' Filter And 'Hour Of Day' Filter Check Boxes Are Checked By Default
Library           AutoItLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}



*** Test Cases ***

Validate That 'Day Of Week' Filter And 'Hour Of Day' Filter Check Boxes Are Checked By Default
    [Tags]      PMEX_CDB    Report_Manager      NetAn_UG_PMEX_TC94
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    verify that the filter check boxes are checked by default
    Capture page screenshot
   
    

 