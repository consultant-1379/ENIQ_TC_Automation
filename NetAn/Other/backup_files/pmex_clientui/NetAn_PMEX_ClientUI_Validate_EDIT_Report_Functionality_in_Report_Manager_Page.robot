*** Settings ***
Force Tags  suite
Documentation     PMEx Edit Report Testcase

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
Verify edit report in PMEX client
    [Tags]  pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientReport.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	Verify edit report        ${object}[TC01]
	
    
*** Keywords ***   
Verify edit report 
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for pmex usecase2    ${scripts}\\pmexEditReport.py     ${data}     ${loc}		MOID
	Log 	${test_script}
	Execute iron python script for pmexusecase      ${test_script}     False 
	${ReportNameInput}=    Read parameters from the text file    ${file_loc}\\title.txt
    ${ReportNamesInList}=    Read parameters from the text file    ${file_loc}\\reportDetails.txt
    DataIntegrity_Keywords.Verify report is created		${ReportNamesInList}		${ReportNameInput}
    ${reportDescription}=    Read parameters from the text file    ${file_loc}\\reportnameDesc.txt
    Verify the report description is edited		${reportDescription}		EditedDesc
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
    
    
    