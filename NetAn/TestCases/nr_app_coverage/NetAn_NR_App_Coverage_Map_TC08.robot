*** Settings ***
Documentation     Validate NR Historical Trend for 6M for Downlink DL Throughput >= 10.00 Mbps in NR App coverage
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
Validate NR Historical Trend for 6M for Downlink DL Throughput >= 10.00 Mbps
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_08       NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Settings
	Open Performance target
	Select downlink performance
	Select uplink performance
	Click on submit button
	Navigating to Home
	Sleep    5s
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	Select from Uplink/Downlink dropdown	Downlink
	select the performance target		DL Throughput >= 10.00 Mbps
	${DateValue} =    get NR date value
	Select NR name    G2RBS01
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	click on button    Historical Trend >>
	verify the page title    NR Historical Trend
	${DateValue} =    get NR date value
	Select NR name    G2RBS01
	#Mark on the Histroical Trend for Selected Cell chart
	${CellFailureRate}=	 	record the tooltip values for Selected cells for failure rate
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-app-coverage/nrappCoverageDataIntegrity.json    TC05
	${complete_sql_query}=    Replace the Date value    ${sql_query}    ${DateValue}
	${DB_Val}=     Query Sybase database    ${complete_sql_query}     
	${DB_VALUE}=	Format DB Value of Cell Failure Rate  	  ${DB_Val}
    Compare UI and DB values   ${CellFailureRate}     ${DB_VALUE}
	Capture page screenshot
	Check for the error notification is not present
	[Teardown]    Test teardown
 		
 	