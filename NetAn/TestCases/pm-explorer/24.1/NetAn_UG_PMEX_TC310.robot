*** Settings ***
Documentation     check Information link getting createed for Custom Flex KPI 
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

check Information link getting created for Custom Flex KPI 
    [Tags]       PMEX_CDB      EQEV-134871
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Click on scroll down button    6    20
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on Refresh nodes button
    Select Nodes as       ERBS1
    click on scroll down button        6       30
    Select Aggregation    No Aggregation 
    Select the measure type  CUSTOM_KPI
    Select the KPIs       Flex_customkpi
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	click on button    Create Information Link(s)
	validate the page title    Create Information Link(s)
	${InformationLink}=    enter the information link name    InfoLink_
	select a Information Link Storage Location and Save it   PMEX Reports
	Capture page screenshot
	