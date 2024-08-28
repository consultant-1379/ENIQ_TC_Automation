*** Settings ***
Documentation     Testing NodeCollection Manager in PMA-Dynamic

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
Verify Dynamic NodeCollection Creation
    [Tags]  PMA_AdminPage
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/PMADynamicNodeCollection.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify dynamic node collection creation and verify in list     ${object}[${key}]
    END

    
  
    
*** keywords ***
Verify dynamic node collection creation and verify in list  
	[Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA dynamic node collection manager     ${scripts}\\PMADynamicCollectionCreationVerification.py      ${data}		${loc}																																   
    Execute iron python script for pma retention period		${test_script}     False
    ${collectionNameInput}=    Read parameters from the text file    ${file_loc}\\CollectionNameInput.txt
    ${collectionInList}=    Read parameters from the text file    ${file_loc}\\CollectionName.txt
    Validate the collection name in collection list     ${collectionInList}	   ${collectionNameInput}
    [Teardown]     Test teardown steps
       
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application


    