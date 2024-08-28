*** Settings ***
Force Tags  suite
Documentation     PMEx Delete in Report Manager Testcase

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
Verify delete button in report manager in PMEX client
    [Tags]  pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientDeleteReport.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	FOR   ${key}   IN  @{object.keys()}
	    IF     '${count}'=='0'
                Run keyword       Verify report deletion in pmex client       ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Verify report deletion in pmex client       ${object}[${key}]
		END
    END
    
*** Keywords ***   
Verify report deletion in pmex client
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for pmex usecase2    ${scripts}\\pmexDeleteReport.py     ${data}     ${loc}		MOID
	Log 	${test_script}
	Execute iron python script for pmexusecase      ${test_script}     False 
    ${ReportNameInput}=    Read parameters from the text file    ${file_loc}\\title.txt
    ${ReportNameInList}=    Read parameters from the text file    ${file_loc}\\reportnameDesc.txt
    Verify report is created		${ReportNameInList}		${ReportNameInput}
    ${reportList}=    Read parameters from the text file    ${file_loc}\\reportDetails.txt
    Verify report is deleted     ${reportList}	   ${ReportNameInput} 
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
    
    
    