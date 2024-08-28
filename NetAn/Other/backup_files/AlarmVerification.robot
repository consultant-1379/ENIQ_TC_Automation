*** Settings ***
Documentation     PMA Alarm verification
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Test Setup       Open Connection And Log In    ${host}    ${username}   ${password}    ${PORT}
Test Teardown    Close Tibco spotfire PMA Application
Suite Teardown    Close All Connections
Suite setup      Suite setup keywords



*** Variables ***

*** Test Cases ***
Verify threshold alarm for different counters
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/alarm_verification.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify alarm     ${object}[${key}]
    END

*** Keywords ***
Verify alarm
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
	${test_script}=    Get iron_python script for PMA Alarm verification    ${scripts}\\AlarmVerification.py     ${data}
    Execute iron python script     ${test_script}     False 
    ${alarm_name}=     Get Alarm name
    ${sql_query}=    set variable     select * from DC_Z_ALARM_INFO_RAW
    ${op}=      Execute Query and return output     ${sql_query}
    $Should Contain     ${op}     ${alarm_name}   
    sleep     600
    [Teardown]     Close Tibco spotfire PMA Application
    
Suite setup keywords
    Open Connection And Log In    ${host}    ${username}   ${password}    ${PORT}
    Set Screenshot Directory   ./Screenshots
