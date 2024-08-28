*** Settings ***

Documentation     Check Measures List Is Displayed As Per The Selected Measure Type
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Check Measures List Is Displayed As Per The Selected Measure Type
	[Tags]       PMEX_CDB     Report_Manager    NetAn_UG_PMEX_TC45
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Click on scroll down button    6    20
    Select Get Data For    Node(s)
    click on scroll down button        6       30
    Select Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select the measure type    COUNTER   
    Select KPIs    eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    verify that the selected measure is present in Selected Measures    eric-act-mapi-requests-recv.DC_E_CCDM_ACT_MAPI_RAW
    Capture page screenshot