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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verify Filtered Data Page For Avg_int_PUSCH
	open uplink interference analysis
	Go to home page if not already at home
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	select Interference Measure and Aggregation as    Interference Power    Average
	click the button    PUCCH/PUSCH Analysis
	verify the page title    PUCCH/PUSCH Analysis
	make selection on the PUCCH Cells chart
	click the button    PUCCH/PUSCH Detailed Analysis >> 
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	select days for filtered data
	Click on the scroll down button    4    20
	click on Fetch button
	make selection on Interference Level chart
	click the button    Filtered Data >>
	verify the page title    PUCCH/PUSCH Filtered Raw Data
	${dateAndTime}    ${kpiValue}=    reading the dateTime and KPI values
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    Avg_int_PUSCH
	${DB_Value}=    Query the ENIQ Database and return output    ${sql_query}    ${dateAndTime}
	Match UI with DB Value    ${kpiValue}     ${DB_Value}
	capture page screenshot
	[Teardown]    Test teardown
 	
 	