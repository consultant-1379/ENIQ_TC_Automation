*** Settings ***

Documentation    Validate if Available measures values are listed based on MO Class selection
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
Validate if Available measures values are listed based on MO Class selection
    [Tags]       PMEX_CDB       Report_Manager
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as       ERBS1
    Click on scroll down button     6    20
    Select the Aggregation    No Aggregation
    Select MOClass as    AclEntryIpv4Stats
    Verify the available measures    aclEntryPackets.DC_E_TCU_ACLENTRYIP4_RAW
    Capture page screenshot