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
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py

Test Teardown     Close Tibco spotfire PMA Application

Suite setup       Suite setup keywords



*** Variables ***

*** Test Cases ***
Verify if the data is visible for the created Custom KPI is PMA
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMA_PDFandFlexCounter.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify alarm has data     ${object}[${key}]
    END

*** Keywords ***
Verify alarm has data
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
	${test_script}=    Get iron_python script for PMA Alarm verification    ${scripts}\\AlarmVerification.py     ${data}
    Execute iron python script     ${test_script}     False
    sleep    5
    [Teardown]     Close Tibco spotfire PMA Application
    
Suite setup keywords
    
    Set Screenshot Directory   ./Screenshots
