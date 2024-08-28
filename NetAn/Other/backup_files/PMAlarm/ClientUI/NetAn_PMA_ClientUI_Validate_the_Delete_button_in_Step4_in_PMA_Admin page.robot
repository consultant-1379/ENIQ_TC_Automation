*** Settings ***
Documentation     Testing deleteButton in EnmConnections in Step4
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
Validate Delete Button in Step4 in PMA Admin page from Client
	[Tags]  PMA_AdminPage
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${enmConntn}= 	set variable 	ieatenm5300-9.athtem.eei.ericsson.se
    ${test_script}=    Get iron_python script for PMA enm delete button scenario     ${scripts}\\PMAEnmDeletionVerification.py      ${enmConntn}		${loc}																																   
    Execute iron python script for pma retention period		${test_script}     False
    ${enmContnList}=    Read parameters from the text file    ${file_loc}\\DataSourceList.txt
    Verify datasource is deleted from the connected datasource list     ${enmContnList}	  ${enmConntn}
    [Teardown]     Test teardown steps
    
  
    
*** keywords ***
    
Test teardown steps
    Capture Screen
    Close Tibco spotfire PMA Application

    