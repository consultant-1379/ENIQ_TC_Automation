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
Verify Alarm generation and Data Integrity
    [Tags]  moid
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMAClientUsecase.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Alarm Generation for threshold alarm     ${object}[${key}]
    END
    
*** Keywords ***  
Verify Alarm Generation for threshold alarm
    [Arguments]      ${data}
    open pm alarm analysis
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_1
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2A
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_2B
    Verify worker files are scheduled for PM Alarm      WorkerAnalysis_3
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA Alarm verification for usecase    ${scripts}\\AlarmRuleCreationUseCase.py     ${data}		${loc}																																	   
    Execute iron python script for pma use case   ${test_script}     False 
    ${alarmInput}=    Read parameters from the text file    ${file_loc}\\AlarmNameInput.txt
    ${alarmTitle}=    Read parameters from the text file    ${file_loc}\\AlarmTitle.txt
    DataIntegrity_Keywords.Verify alarm title      ${alarmInput}    ${alarmTitle}
    ${alarmType}=    Read parameters from the text file    ${file_loc}\\AlarmDetailsFromFetchData.txt
    DataIntegrity_Keywords.verify alarm type	${data}[Alarm_Type]		${alarmType}
    ${columns}=    Read parameters from the text file    ${file_loc}\\ColumnDetailsFromFetchData.txt
    Verify columns displayed in spotfire   ${data}[Columns_displayed]		${columns}
    ${rowValuesFromReport}=    Read parameters from the text file    ${file_loc}\\alarmReportDetails.txt
    Verify alarm state in spotfire    ${rowValuesFromReport}    Inactive
   	${alarmState}=    Read parameters from the text file    ${file_loc}\\alarmState.txt
    Verify alarm state in spotfire after activating the alarm      ${alarmState}     Active
    DataIntegrity_Keywords.Verify alarm state in DB      ${alarmTitle}   Active
    ${alarm_criterias}=    Read parameters from the text file    ${file_loc}\\AlarmCriteria.txt
    ${alarm_criteria}=     Get the alarm criteria		${alarm_criterias}
    Sleep 		600s
    Verify alarm in DC_Z_ALARM_NETAN_RAW      ${alarmTitle}     ${alarm_criteria}
    Verify alarm generated in ENM    ${alarmTitle}     ${data}[Node]    ${data}[Probable_cause]     ${alarm_criteria}
	${DATEID_Value}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_Value}=    Read parameters from the text file    ${file_loc}\\moidvalue.txt
   	${MEASURE_Values}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
   	Verify data integrity of measures from client    ${MEASURE_Values}      ${DATEID_Value}     ${UNIQUE_ID_Value}     ${data}[SQL1]        ${data}[SQL2]        ${data}[SQL3]        ${data}[SQL4] 																	
    [Teardown]     Test teardown steps  
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application 
    Close Browser
    
Suite setup steps
      Set Screenshot Directory   ./Screenshots    
    