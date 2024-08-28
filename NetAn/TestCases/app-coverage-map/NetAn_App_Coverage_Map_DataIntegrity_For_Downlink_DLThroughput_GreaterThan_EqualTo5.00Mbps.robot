*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEAppCoverageMapKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Suite setup       Suite setup steps

*** Test Cases ***
Verify DataIntegrity
    [Tags]  appCoverageDataIntegrity
    Log		${EXEC_DIR}
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/app-coverage-map/appCoverageDataIntegrity.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    Run Keyword And Continue on Failure       Verify DataIntegrity for Downlink DL Throughput >=5.00 Mbps    ${object}[TC03]
    
    
*** Keywords ***  

Verify DataIntegrity for Downlink DL Throughput >=5.00 Mbps
	[Arguments]      ${data}
	open app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on button    Cell Performance
	verify the page title    Cell Performance
	verify Cell Performance Ranking Page opens on App Coverage Map Analysis
	Select from Uplink/Downlink dropdown	Downlink
	select the performance target		DL Throughput >=5.00 Mbps
	sleep 	10s
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	${ERBSValue}  ${CELLValue}	${AvgFailedSessions}=	 record the tooltip values
	${DB_Val}=     Query ENIQ database for Avg failed User Session  ${data}    ${ERBSValue}    ${CELLValue}		
	${DB_VALUE}=	Format the DB Value	    ${DB_Val}
    Verify UI value is matching with DB value    ${AvgFailedSessions}     ${DB_VALUE}
	Capture page screenshot
	[Teardown]    Test teardown
 		


Test teardown steps
    Capture page screenshot
    Close Browser

Suite setup steps
    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot	 	