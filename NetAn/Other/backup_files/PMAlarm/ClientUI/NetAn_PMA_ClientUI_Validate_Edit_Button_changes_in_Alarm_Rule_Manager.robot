*** Settings ***
Force Tags  suite
Documentation     PMAUseCase Edit Testcase
Library           DatabaseLibrary
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

Suite Setup       Suite setup steps

*** Variables ***


*** Test Cases ***
Verify edit functionality of PMA
    [Tags]  moid
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMAEditAlarm.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify edit button of alarm     ${object}[${key}]
    END
    
*** Keywords ***  
Verify edit button of alarm
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA Alarm verification for usecase    ${scripts}\\AlarmEdit.py     ${data}		${loc}																																	   
    Execute iron python script for pma use case   ${test_script}     False 
    ${alarmInput}=    Read parameters from the text file    ${file_loc}\\AlarmNameInput.txt
    ${alarmTitle}=    Read parameters from the text file    ${file_loc}\\AlarmTitle.txt
    DataIntegrity_Keywords.Verify alarm title      ${alarmInput}    ${alarmTitle}
    ${rowValuesFromReport}=    Read parameters from the text file    ${file_loc}\\alarmReportDetails.txt
    Verify specific problem of alarm is changed     ${rowValuesFromReport}    Edited
    [Teardown]     Test teardown steps  
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application 
    Close Browser
    
Suite setup steps
      Set Screenshot Directory   ./Screenshots    
    