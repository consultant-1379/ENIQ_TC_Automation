*** Settings ***
Documentation     Verifying 'Network Overview' Page in NR App coverage
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRAppKeywords}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py



*** Test Cases ***
Verifying 'Network Overview' Page
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_10        NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Settings
	verify the page title    Settings
	Open Performance target
	Select downlink performance
	Click on submit button
	Navigating to Home
	Sleep    5s
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Network Overview
	verify the page title    NR Network Overview
	verify that the Performance Target dropdowns are visible
	select the performance target in Network overview(DL)		DL Throughput >= 700.00 Mbps
	mark on the network overiew DL chart 
	${DateValue} =    get NR date value	
	Select NR name    G2RBS01
	${sql_query}=    get sql query from json file     ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-app-coverage/nrappCoverageDataIntegrity.json    TC08
	${complete_sql_query}=    Replace the Date value    ${sql_query}    ${DateValue}
	${DB_Val}=     Query Sybase database    ${complete_sql_query}     
	${DB_VALUE}=	Format DB Value of Cell Failure Rate  	  ${DB_Val}
	validate rate target value with failure rate    ${DB_VALUE} 
    Check for the error notification is not present	
	[Teardown]    Test teardown

 		
 	