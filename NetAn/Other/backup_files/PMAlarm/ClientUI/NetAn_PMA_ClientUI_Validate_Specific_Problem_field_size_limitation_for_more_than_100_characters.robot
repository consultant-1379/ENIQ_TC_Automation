*** Settings ***
Force Tags  suite
Documentation     PMAUseCase Testcase
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
Validate the 'Alarm Information'Column in Alarm Rule Manager page
    [Tags]  moid
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_ClientUI.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Add Test Case    TC03   Validate the 'Alarm Information'Column for Specific problem error message   ${object}[TC03]
    
*** Keywords ***  
Validate the 'Alarm Information'Column for Specific problem error message
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA Alarm verification for usecase    ${scripts}\\AlarmInfoValidationError.py     ${data}		${loc}																																	   
    Execute iron python script for pma use case   ${test_script}     False 
    ${errorMsg}=    Read parameters from the text file    ${file_loc}\\Message.txt
    Validate specific problem error message in client   ${errorMsg}		Specific Problem cannot be more than 100 characters long.
    [Teardown]     Test teardown steps  
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application 
    Close Browser
    
Suite setup steps
      Set Screenshot Directory   ./Screenshots    
    

