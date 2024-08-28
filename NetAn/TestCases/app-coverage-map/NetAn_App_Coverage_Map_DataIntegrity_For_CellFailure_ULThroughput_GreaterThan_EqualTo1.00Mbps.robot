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
Suite teardown	  Suite teardown steps

*** Test Cases ***

Verify DataIntegrity for CellFailure Rate of Uplink UL Throughput >=1.00 Mbps
	open app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	verify the page title    Cell Performance
	verify Cell Performance Ranking Page opens on App Coverage Map Analysis
	Select from Uplink/Downlink dropdown	Uplink
	select the performance target for uplink		UL Throughput >=1.00 Mbps
	${hourID}=    select hour id
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	${ERBSValue}   ${CELLValue}	    ${AvgFailedSessions}=	 record the tooltip values of Worst Performing Cells Graph
	${DateValue}	${CellFailureRate}=	 	place cursor on "Cell Failure Rate over Time" chart and record its tooltip values
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/app-coverage-map/appCoverageDataIntegrity.json    TC18
	${DB_Val}=     Query ENIQ database for Cell Failure Rate    ${sql_query}    ${ERBSValue}    ${CELLValue}    ${DateValue}    ${hourID}
	${DB_VALUE}=	Format DB Value of Cell Failure Rate  	  ${DB_Val}
    Verify UI value is matching with DB value    ${CellFailureRate}     ${DB_VALUE}
	Capture page screenshot
	[Teardown]    Test teardown
 		
*** Keywords ***

Test teardown steps
    Capture page screenshot
    Close Browser

Suite setup steps    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot	 	