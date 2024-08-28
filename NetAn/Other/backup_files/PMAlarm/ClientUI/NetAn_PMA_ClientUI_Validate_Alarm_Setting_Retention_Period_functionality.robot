*** Settings ***
Documentation     Testing Core Nodetypes

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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


Suite setup       Suite setup steps

*** Variables ***


*** Test Cases ***
Validate the 'Alarm setting' functionality in Admin page
	[Tags]  PMA_AdminPage
    Launch Tibco spotfire PMA Application 
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${Retention_Period}= 	set variable 	10
    ${test_script}=    Get iron_python script for PMA Retention period scenario    ${scripts}\\AlarmRetentionPeriod.py     ${Retention_Period}		${loc}																																	   
    Execute iron python script for pma retention period		${test_script}     False
    ${alarmName}=    Read parameters from the text file    ${file_loc}\\AlarmDetails.txt
    ${alarmDeletionDate}=    Read parameters from the text file    ${file_loc}\\AlarmDeleteDt.txt
    DataIntegrity_Keywords.Validate the alarm deletion date is per the retention period   ${alarmName}	${alarmDeletionDate}    10 days
    [Teardown]     Test teardown steps
    
  
    
*** keywords ***
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application

Suite setup steps
    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Close All Connections
    