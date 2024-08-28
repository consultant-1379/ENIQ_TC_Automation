*** Settings ***

Documentation     Verify Creation Of ILs For Collections
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

Verify Creation Of ILs For Collections
    [Tags]    PMEX_CDB    Report_Manager
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
    Click on Create Collection button
	validate the page title    Create Collection
	${collectionName}=    enter the Collection name
	verify that the DataSource is present and select it    NetAn_ODBC
	select the System area as    Core
	select the Node type    CCDM
	Click on scroll down button     6    20
	click on button    Fetch nodes
	select the Nodes    CCDM01,CCDM02,CCDM03,CCDM04
	click on button    Add >>
	click on button    Save
	validate the page title    Manage Collection
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Collection
    Select Collections    ${collectionName}
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