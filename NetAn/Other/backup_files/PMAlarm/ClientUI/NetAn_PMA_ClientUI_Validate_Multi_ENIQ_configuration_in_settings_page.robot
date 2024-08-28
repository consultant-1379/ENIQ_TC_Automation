*** Settings ***
Documentation     Testing Multi EniqConnections
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
Validate multi Eniq connections in client
	[Tags]  PMA_AdminPage
    Launch Tibco spotfire PMA Application 
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\ 
    ${DataSource}= 	set variable 	NetAn_ODBC,NetAn_4140
    ${test_script}=    Get iron_python script for PMA eniq delete button scenario     ${scripts}\\PMAMultiEniqConnection.py      ${DataSource}		${loc}																																   
    Execute iron python script for pma retention period		${test_script}     False
    ${dataSourceList}=    Read parameters from the text file    ${file_loc}\\DataSourceList.txt
    Validate multi ENIQ connections are displayed     NetAn_ODBC,NetAn_4140			${dataSourceList}
    [Teardown]     Test teardown steps
    
  
    
*** keywords ***
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application

Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Close All Connections
    