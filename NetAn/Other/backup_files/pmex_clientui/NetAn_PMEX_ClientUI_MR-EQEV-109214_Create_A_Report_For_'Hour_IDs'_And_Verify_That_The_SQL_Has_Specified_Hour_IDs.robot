*** Settings ***
Force Tags  suite
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMExplorerWebUI.robot
Suite Setup         Suite setup steps

*** Test Cases *** 

Verify That The Created Report Has The Specified Hour IDs In Its SQL
    [Tags]          pmexClientUI 
	Launch the Tibco spotfire PMEx Application
	${loc}=		Replace String 		${file_loc}	   \\		\\\\
	${test_script}=    Get iron_python script for navigation    ${scripts}\\pmexNavigateToReportManager.py
	Log 	${test_script}
	Go to the Report Manager Page      ${test_script}     False
    select the report with hour id and click on Edit
    open data table properties and verify the sql
    [Teardown]     Test teardown steps 
    
*** keywords ***  
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application
    
Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    capture screen    
    