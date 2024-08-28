*** Settings ***
Documentation     Verifying 'Cell cite Location' Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRAppKeywords}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py



*** Test Cases ***
Verifying 'Cell cite Location' Page
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_15       NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Settings
	verify the page title    Settings
	Open Performance target
	Select uplink performance
	Click on submit button
	Navigating to Home
	Sleep    5s
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	Select from Uplink/Downlink dropdown	Uplink
	select the performance target for UL		UL Throughput >= 50.00 Mbps
	${DateValue} =    get NR date value
	Select NR name    G2RBS01
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	click on button    Cell Site Location >>
	verify the page title    NR Cell Site Location 
	${DateValue} =    get NR date value
	
	Validate Map Chart switch to table 
	Validate table value
	
	${CellFailureRate}    ${avgFailedSessions}=	 	record the tooltip values for Cell site page
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-app-coverage/nrappCoverageDataIntegrity.json    TC12
	${complete_sql_query}=    Replace the Date value    ${sql_query}    ${DateValue}
	${DB_Val}=     Query Sybase database    ${complete_sql_query}     
	${DB_VALUE}=	Format DB Value of Cell Failure Rate  	  ${DB_Val}
    Compare UI and DB values   ${CellFailureRate}     ${DB_VALUE}
	Compare UI and DB values in avg   ${avgFailedSessions}     ${DB_VALUE}
	Capture page screenshot

	${sql_query1}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-app-coverage/nrappCoverageDataIntegrity.json    TC12
	${complete_sql_query1}=    Replace the Date value    ${sql_query1}    ${DateValue}
	${DB_Val1}=     Query Sybase database    ${complete_sql_query1}     
	${DB_VALUE1}=	Format DB Value of Cell Failure Rate  	  ${DB_Val1}
    Compare UI and DB values   ${CellFailureRate}     ${DB_VALUE1}
	Capture page screenshot
	Check for the error notification is not present
	[Teardown]    Test teardown

 		
 	