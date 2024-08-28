*** Settings ***
Documentation     Verify the CSCF: Filtered Data Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/IMSCapacityWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot


*** Test Cases ***

Verify the Functionality of CSCF: Filtered Data Page
    [Tags]      TC02     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    Sleep 	5s
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Traffic' link
    wait for the page 	 CSCF: Traffic
    validate the page title as		CSCF: Traffic
    verify buttons for Traffic      CSCF
    verify Time range and KPIs are displayed
    Click on the scroll down button     1       9
    In KPIs section select    Registered Users
    validate the title	  Node KPI Performance
    select CSCF nodes from 'Node KPI Performance' section for filtered data
    validate the title 	  KPI Details
    wait for the page 	 CSCF: Traffic
    make selection in the 'KPI Details' graph
    click on button      CSCF: Filtered Data
    wait for the page 	 CSCF Filtered Data
    validate the page title as		CSCF Filtered Data

    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for CSCF
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     cscf_Registered_Users
    ${DB_Value}=    query the eniq database for cscf    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
