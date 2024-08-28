*** Settings ***

Documentation     Verify Creation Of ILs For SubNetwork
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

Verify Creation Of ILs For SubNetwork
    [Tags]    PMEX_CDB    Report_Manager
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    SubNetwork
    select SubNetwork    SubNetwork
    Select the Aggregation    No Aggregation
    Select the measure type    COUNTER   
    Select KPIs    eric-act-notification-nudr-prov-successful-responses-recv.DC_E_CCDM_ACT_NOTIF_NUDR_PROV_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    Click on fetch pmdata button
    Verify the page title    No Aggregation      NetAn_ODBC     Day
	Click on create information link button
	validate the page title    Create Information Link(s)
	verify that the label and input fields are visible
	${InformationLink}=    enter the information link name    InfoLink_
	select a Information Link Storage Location and Save it   PMEX Reports
	Capture page screenshot