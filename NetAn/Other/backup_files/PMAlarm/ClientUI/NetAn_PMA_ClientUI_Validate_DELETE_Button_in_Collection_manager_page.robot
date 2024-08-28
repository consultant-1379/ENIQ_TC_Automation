*** Settings ***
Documentation     Testing deleteButton in CollectionManager
#Test Setup       Open Connection And Log In     ${host}     ${username}    ${password}    ${PORT}
Test Teardown    Close All Connections
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
Verify Delete Button functionality in collection manager of PMA
	[Tags]  PMA_AdminPage
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${test_script}=    Get iron_python script for PMA collection delete scenario     ${scripts}\\PMACollectionDeletionVerification.py		${loc}																																   
    Execute iron python script for pma retention period		${test_script}     False
    ${deletedCollection}=    Read parameters from the text file    ${file_loc}\\CollectionName.txt
    ${collectionList}=    Read parameters from the text file    ${file_loc}\\CollectionList.txt
    Verify collection is deleted    ${collectionList}	  ${deletedCollection}
    [Teardown]     Test teardown steps
    
  
    
*** keywords ***   
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application

Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Close All Connections
    