*** Settings ***
Force Tags  suite
Documentation     Create a Report as Administrator

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
										

*** Variables ***


*** Test Cases ***
Create a Report as Administrator	
    [Tags]  dataIntegrity          pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEX-TR-IA11419.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    IF     '${count}'=='0'
                Run keyword       Verify report creation and Data Integrity       ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Verify report creation and Data Integrity       ${object}[${key}]
		END
        
    END
    
*** Keywords ***   
Verify report creation and Data Integrity
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for pmex usecase2    ${scripts}\\pmexScriptUsecase.py     ${data}     ${loc}		MOID
	Log 	${test_script}
	Execute iron python script for pmexusecase      ${test_script}     False 
    ${DataFromEniq}=    Read parameters from the text file    ${file_loc}\\PMDataColumnValue.txt
    Verify the selected node,node type and measure or kpi are displayed in the data from ENIQ	${data}   	${DataFromEniq}
    ${title}=    Read parameters from the text file    ${file_loc}\\title.txt
    Verify the title with respect to the aggregation inputs 	${data}		NetAn_ODBC   	${title} 
    ${ReportNameDescInputs}=    Read parameters from the text file    ${file_loc}\\reportnameDesc.txt
    ${ReportName}  ${ReportDesc}=   get the user inputs report name and description	${ReportNameDescInputs}
    ${ReportDetailsFromClient}=    Read parameters from the text file    ${file_loc}\\reportDetails.txt
    ${DB_ReportName}=  Query Postgre database     ${data}[SQL1]    ${ReportName} 
    Verify the report is saved to the DB     ${DB_ReportName}     ${ReportName}
    Verify the data file in Custom Library    ${ReportName}
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
    
    
    