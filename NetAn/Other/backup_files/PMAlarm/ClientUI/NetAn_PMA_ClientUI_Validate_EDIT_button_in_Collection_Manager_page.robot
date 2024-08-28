*** Settings ***
Documentation     Testing Edit Node in NodeCollection Manager PMA

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


Suite setup       Suite setup steps

*** Variables ***


*** Test Cases ***
Verify Edit Nodes of Static NodeCollection 
    [Tags]  PMA_AdminPage
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMANodeCollectionEdit.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify edited node in collection      ${object}[${key}]
    END

    
  
    
*** keywords ***
Verify edited node in collection  
	[Arguments]      ${data}
    Launch Tibco spotfire PMA Application 
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA node edit collection manager     ${scripts}\\PMACollectionEditVerification.py      ${data}		${loc}																																   
    Execute iron python script for pma retention period		${test_script}     False
    ${Nodes}=    Read parameters from the text file    ${file_loc}\\NodeList.txt
    DataIntegrity_Keywords.Verify edited nodes displayed for collection      ${Nodes}	   ${data}[EditNode]
    [Teardown]     Test teardown steps
       
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application

Suite setup steps
    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Close All Connections
    