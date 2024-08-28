*** Settings ***
Documentation     Testing Export button in Alarm Rule Manager page in Client
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           AutoItLibrary
Library           Collections
Library           String
Library           SSHLibrary
Library           SikuliLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


Suite setup       Suite setup steps

*** Variables ***


*** Test Cases ***
Verify Export button functionality in Alarm Rule Manager Page
    [Tags]  PMA_AdminPage
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA export button     ${scripts}\\PMAExportVerification.py     ${loc}																																   
    #Execute iron python script for pma retention period		${test_script}     False
    ${ExportMessage}=    Read parameters from the text file    ${file_loc}\\Message.txt
    DataIntegrity_Keywords.Verify the export message for successful export    ${ExportMessage}
    [Teardown]     Test teardown steps

  
    
*** keywords ***
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application

Suite setup steps
   Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Close All Connections
    