*** Settings ***
Documentation     Verify the Cell Performance for Average Failed Session of UL Throughput >=150.00 Mbps in NR App coverage
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
Validate Cell Performance for Average Failed Session of UL Throughput >=150.00 Mbps
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_05      NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Settings
	verify the page title    Settings
	Open Performance target
	Select downlink performance
	Select uplink performance
	Click on submit button
	Navigating to Home
	Sleep    5s
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	verify the page title    NR Cell Performance
	Select from Uplink/Downlink dropdown	Uplink
	select the performance target for UL		UL Throughput >= 150.00 Mbps
	${DateValue} =    get NR date value
	Select NR name    G2RBS01
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	${ERBSValue}   ${CELLValue}	    ${AvgFailedSessions}=	 record the tooltip values
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-app-coverage/nrappCoverageDataIntegrity.json    TC02
	${complete_sql_query}=    Replace the Date value    ${sql_query}    ${DateValue}
	${DB_Val}=     Query Sybase database    ${complete_sql_query}
	${DB_VALUE}=	Format DB Value of Cell Failure Rate  	  ${DB_Val}
    Verify UI value is matching with DB value    ${AvgFailedSessions}     ${DB_VALUE}
	Capture page screenshot
	Check for the error notification is not present
	[Teardown]    Test teardown
 		
 	