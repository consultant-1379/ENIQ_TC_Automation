#PMA_76
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
Validate the Measure Type: "if more than one counter is selected from different tables with a Mutitable KPI having those tables in TableName column " combination list in Alarm Rule Manager page
    [Tags]  MultiTableKPI
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_ClientUI.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Add Test Case    TC06   Validate the Measure Type combination list in Alarm Rule Manager page      ${object}[TC06]
    
*** Keywords ***  
Validate the Measure Type combination list in Alarm Rule Manager page
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA Alarm verification for usecase    ${scripts}\\PMAMultiTablekpiCounter.py     ${data}		${loc}																																	   
    Execute iron python script for pma use case   ${test_script}     False 
    ${alarmInput}=    Read parameters from the text file    ${file_loc}\\AlarmNameInput.txt
    ${alarmTitle}=    Read parameters from the text file    ${file_loc}\\AlarmTitle.txt
    DataIntegrity_Keywords.Verify alarm title      ${alarmInput}    ${alarmTitle}
    ${columns}=    Read parameters from the text file    ${file_loc}\\ColumnDetailsFromFetchData.txt
    Verify columns displayed in spotfire   ${data}[Columns_displayed]		${columns}
    [Teardown]     Test teardown steps  
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application 
    Close Browser
    
Suite setup steps
      Set Screenshot Directory   ./Screenshots    
 