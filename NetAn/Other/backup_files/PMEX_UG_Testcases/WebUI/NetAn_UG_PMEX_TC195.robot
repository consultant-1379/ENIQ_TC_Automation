*** Settings ***

Documentation    Validate if MO Class Filter values are listed without commas and single quotes
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

*** Test Cases ***
Validate if MO Class Filter values are listed without commas and single quotes
    [Tags]       PMEX_CDB       Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as       G2RBS01
    Click on scroll down button     6    20
    Select the Aggregation    No Aggregation
    Select all MO classes in UI for comma
    Capture page screenshot