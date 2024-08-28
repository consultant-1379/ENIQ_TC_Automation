*** Settings ***
Force Tags  suite
Documentation     Verify report creation and data integrity in PMEX client

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
Verify report creation and data integrity in PMEX client
    [Tags]  dataIntegrity        pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientUseCase.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    IF     '${count}'=='0'
                Run keyword       Verify report creation and Data Integrity       ${object}[TC01]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Verify report creation and Data Integrity       ${object}[TC01]
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
    ${DB_ReportName}=  Query Postgres database     ${data}[SQL1]    ${ReportName} 
    Verify the report is saved to the DB     ${DB_ReportName}     ${ReportName}
    Verify report name, access type, description, reportTableList, ENIQName, tables added to report are displayed in Report Manager GUI    ${data}	${ReportDetailsFromClient}  ${ReportName}  ${ReportDesc}	${title} 
   	${DataOfCol1}=    Read parameters from the text file    ${file_loc}\\dataOfCol1.txt
   	${DataOfCol2}=    Read parameters from the text file     ${file_loc}\\dataOfCol2.txt
   	${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
   	Verify Dataintegrity of the Measure from client      ${data}     ${DataOfCol1}     ${DataOfCol2}       ${data}[Formula]      ${MEASURE_Value}
    [Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
 
    