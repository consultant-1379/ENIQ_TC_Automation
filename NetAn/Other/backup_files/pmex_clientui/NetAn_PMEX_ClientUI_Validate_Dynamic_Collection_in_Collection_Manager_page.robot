*** Settings ***
Force Tags  suite
Documentation     PMEx Dynamic Collection Creation Testcase

Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library          SSHLibrary
Library          DateTime
Library 		 PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py

Suite Setup         Suite setup steps																							   
										

*** Variables ***


*** Test Cases ***
Verify dynamic collection creation in PMEX client
    [Tags]  dataIntegrity           pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientCollection.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Verify dynamic collection creation in client     ${object}[TC02]
   
    
*** Keywords ***   
Verify dynamic collection creation in client
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=     Get iron_python script for pmex dynamic node collection manager    ${scripts}\\pmexDynamicCollectionCreationVerification.py     ${data}     ${loc}		
	Log 	${test_script}
	Execute iron python script for pmexusecase      ${test_script}     False 
    ${collectionNameInput}=    Read parameters from the text file    ${file_loc}\\CollectionNameInput.txt
    ${collectionInList}=    Read parameters from the text file    ${file_loc}\\CollectionName.txt
    Validate the collection name in collection list     ${collectionInList}	   ${collectionNameInput}
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
       
   
Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot   
 