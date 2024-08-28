*** Settings ***
Documentation     Testing Import Functionality in PMA
Test Teardown    Close All Connections
Library           AutoItLibrary
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           SikuliLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Library           CSVLib
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


Suite setup       Suite setup steps

*** Variables ***


*** Test Cases ***
Validate Import Functionality in PMA Client
	${alarm_rule}=      Change alarm rule name in alarm definition file
	Launch Tibco spotfire PMA Application 
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA Import     ${scripts}\\PMAImport.py      ${alarm_rule}		${loc}																																   
    Execute iron python script for pma    	${test_script}     False
    ${message}=    Read parameters from the text file    ${file_loc}\\Message.txt
    DataIntegrity_Keywords.Validate alarm rule imported is displayed in import result     ${message}			Import Successful
    [Teardown]     Test teardown steps
    
  
    
*** keywords ***
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application

Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Close All Connections
    