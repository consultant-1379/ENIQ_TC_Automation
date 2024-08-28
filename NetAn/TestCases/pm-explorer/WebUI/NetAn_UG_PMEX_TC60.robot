*** Settings ***
Documentation     Validate Nodes Listed for the Selected System Area
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

Validate Nodes Listed for the Selected System Area
    [Tags]     PMEX_CDB          Report_Manager    NetAn_UG_PMEX_TC60
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Select the Aggregation    No Aggregation
    Click on Refresh nodes button
    verify that nodes are visible for the selected Node type
    Capture page screenshot
	