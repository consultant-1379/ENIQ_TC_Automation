*** Settings ***
Documentation     Verify 'Save Information Link' Button on Create Information Link(s) Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Verify 'Save Information Link' Button on Create Information Link(s) Page
    [Tags]       PMEX_KGB      Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Click on scroll down button    6    20
    Select Node type    CCDM
    Select Get Data For as    Node(s)
    click on scroll down button       6       30
    Select the Aggregation    No Aggregation
    click on scroll up button       6       7
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select the measure type    COUNTER   
    Select KPIs    eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	click on button    Create Information Link(s)
	validate the page title    Create Information Link(s)
	${InformationLink}=    enter the information link name    InfoLink_
	select a Information Link Storage Location and Save it   PMEX Reports
	Capture page screenshot
	[Teardown]    Test teardown
	
*** Keywords ***
	
Suite setup steps
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot
	
Test teardown
    Capture page screenshot
    Close Browser