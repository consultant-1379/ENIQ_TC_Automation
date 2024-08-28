*** Settings ***
Documentation     Verify 'Back' Button on Create Information Link(s) Page
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

Verify 'Back' Button on Create Information Link(s) Page
    [Tags]     Report_Manager    PMEX_CDB
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Select the Aggregation    No Aggregation
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
	${InfoamrtionLink}=    enter the information link name    InfoLink_
    ${folder_name}=      return the visible folder name
	select a Information Link Storage Location   ${folder_name}
	click on the button      Upto Parent Directory
	verify that the different locations are visible      ${folder_name}
	Capture page screenshot
	

 