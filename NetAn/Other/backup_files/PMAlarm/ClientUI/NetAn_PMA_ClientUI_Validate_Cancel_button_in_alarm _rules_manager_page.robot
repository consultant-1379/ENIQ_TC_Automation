*** Settings ***
Documentation     Testing Cancel button in Alarm Rules Manger Page in Client

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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


*** Variables ***


*** Test Cases ***
Verify cancel button functionality in alarm creation page
    [Tags]  PMA_AdminPage
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMACancelButton.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify cancel button functionality in alarm creation page in client     ${object}[${key}]
    END

    
  
    
*** keywords ***
Verify cancel button functionality in alarm creation page in client  
	[Arguments]      ${data}
    Launch Tibco spotfire PMA Application 
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA Alarm verification for usecase       ${scripts}\\PMACancelButtonAlarmCreation.py      ${data}		${loc}																																   
    Execute iron python script for pma retention period		${test_script}     False
    ${alarmNameInput}=    Read parameters from the text file    ${file_loc}\\AlarmNameInput.txt
    ${alarmList}=    Read parameters from the text file    ${file_loc}\\AlarmList.txt
    Verify alarm is not present in list     ${alarmList}	   ${alarmNameInput}
    [Teardown]     Test teardown steps
       
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application


    