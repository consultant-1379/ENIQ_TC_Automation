*** Settings ***
Documentation     Add the Interval and check with the 'Define Interval' option
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Add the Interval and check with the 'Define Interval' option
    [Tags]      PMEX_KGB       Report_Manager        NetAn_UG_PMEX_TC05
    open pm explorer analysis
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource as    NetAn_ODBC
    Select System area as    Radio
    Select Node type as    NR
    Select Get Data For as     Node(s)
    Click on Refresh nodes button
    Select Nodes as    G2RBS01
    Select Aggregation as    Node
    Select the measure type   COUNTER
    Select KPIs        PMRADIORACBFAILMSG1OOC.DC_E_NR_BEAM_RAW
    Select time drop down to      Define Interval    
    Verify that Create Interval section is visible

