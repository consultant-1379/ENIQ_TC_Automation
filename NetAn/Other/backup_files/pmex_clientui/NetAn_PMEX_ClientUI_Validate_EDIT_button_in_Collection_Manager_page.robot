*** Settings ***
Force Tags  suite
Documentation     PMEx Client Edit Collection  Testcase

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
Verify edit static collection creation in PMEX client
    [Tags]  pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientCollection.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Verify edit static collection creation in client     ${object}[TC03]
 
    
*** Keywords ***   
Verify edit static collection creation in client
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script for PMEx node edit collection manager      ${scripts}\\pmexEditCollectionVerification.py     ${data}     ${loc}		
	Log 	${test_script}
	Execute iron python script for pmex      ${test_script}     False 
    ${Nodes}=    Read parameters from the text file    ${file_loc}\\NodeList.txt
    DataIntegrity_Keywords.Verify edited nodes displayed for collection      ${Nodes}	   ${data}[EditNode]
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
       
   
Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot   
 