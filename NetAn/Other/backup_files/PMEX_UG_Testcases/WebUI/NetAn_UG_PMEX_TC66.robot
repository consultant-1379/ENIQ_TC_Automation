*** Settings ***
Documentation     Validate that View Button is Disabled If Report is Not Selected
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

Validate that View Button is Disabled If Report is Not Selected
    [Tags]      PMEX_CDB         Report_Manager       NetAn_UG_PMEX_TC66
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
    Select KPIs    ERIC-ACT-MAPI-REQUESTS-RECV.DC_E_CCDM_ACT_MAPI_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on Save Report
	${report_name}=    Enter details to save report to library    Report.    Public    test
	Click on Save report to Library button
	${IsElementInteractable}=    Run Keyword And Return Status    click on button    View
    verify that the element is not interactable    ${IsElementInteractable}    
	Capture page screenshot
	