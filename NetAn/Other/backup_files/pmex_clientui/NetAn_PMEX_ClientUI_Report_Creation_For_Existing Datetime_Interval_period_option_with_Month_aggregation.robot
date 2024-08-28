*** Settings ***
Force Tags  suite
Documentation     Verify Report is getting generated for Existing Datetime Interval period option with Month aggregation in PMEX client

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

*** Variables ***


*** Test Cases ***
Verify Report is getting generated for Existing Datetime Interval period option with Month aggregation in PMEX client
    [Tags]  pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientReport.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	Verify Report is getting generated for Existing Datetime Interval period option with Month aggregation       ${object}[TC15]
	
    
*** Keywords ***   
Verify Report is getting generated for Existing Datetime Interval period option with Month aggregation 
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for pmex usecase2    ${scripts}\\pmexTimePanelScript.py     ${data}     ${loc}		MOID
	Log 	${test_script}
	Execute iron python script for pmexusecase      ${test_script}     False 
    ${reportNameInput}=    Read parameters from the text file    ${file_loc}\\title.txt
    ${ReportName}=    Read parameters from the text file    ${file_loc}\\reportnameDesc.txt
    Verify report is created 	 ${ReportName}		${reportNameInput}
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
    
    
    