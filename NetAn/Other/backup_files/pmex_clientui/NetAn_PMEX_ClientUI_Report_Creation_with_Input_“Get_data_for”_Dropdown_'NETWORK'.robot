*** Settings ***
Force Tags  suite
Documentation     Verify Report Creation with Input 'Get data for' Dropdown 'NETWORK' in PMEX client

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
Verify Report Creation with Input 'Get data for' Dropdown 'NETWORK' in PMEX client
    [Tags]  dataIntegrity       pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMEXClientReport.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	Verify report creation      ${object}[TC09]
	
    
*** Keywords ***   
Verify report creation
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for pmex usecase2    ${scripts}\\pmexReportCreationScript.py     ${data}     ${loc}		MOID
	Log 	${test_script}
	Execute iron python script for pmexusecase      ${test_script}     False 
    ${title}=    Read parameters from the text file    ${file_loc}\\title.txt
    Verify the title with respect to the aggregation inputs 	${data}		NetAn_ODBC   	${title} 
    ${ReportNameDescInputs}=    Read parameters from the text file    ${file_loc}\\reportnameDesc.txt
    ${ReportName}  ${ReportDesc}=   get the user inputs report name and description	${ReportNameDescInputs}
    ${ReportDetailsFromClient}=    Read parameters from the text file    ${file_loc}\\reportDetails.txt
    ${DB_ReportName}=  Query Postgre database     ${data}[SQL1]    ${ReportName} 
    Verify the report is saved to the DB     ${DB_ReportName}     ${ReportName}
    Verify report name, access type, description, reportTableList, ENIQName, tables added to report are displayed in Report Manager GUI    ${data}	${ReportDetailsFromClient}  ${ReportName}  ${ReportDesc}	${title} 
   	[Teardown]     Test teardown steps
    
    
    
Test teardown steps
    Capture screen
    Close Tibco spotfire PMEX Application    
    
    
    
    