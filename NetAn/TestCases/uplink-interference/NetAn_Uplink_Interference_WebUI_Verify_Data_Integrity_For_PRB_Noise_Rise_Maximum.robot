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

Verify Data Integrity For PRB Noise Rise Maximum
	open uplink interference analysis
	Go to home page if not already at home
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	adjust the slider to 500 cells
	select Interference Measure and Aggregation as    Noise Rise    Maximum
	${uiValue}    ${cellValue}=    reading values from the tooltip in chart    PRB Analysis
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/uplink-interference/Uplink-Interference-dataIntegrity-SQLs.json    prbNoiseRiseMaximum
	${DB_Value}=    Query ENIQ database    ${sql_query}    ${cellValue}
	Match UI with DB Value    ${uiValue}     ${DB_Value}
	capture page screenshot
	[Teardown]    Test teardown
 	
 	