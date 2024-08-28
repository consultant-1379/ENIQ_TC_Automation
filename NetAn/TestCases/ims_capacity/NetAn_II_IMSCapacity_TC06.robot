*** Settings ***
Documentation     Verify the HSS-FE: Filtered Data page
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

Verify the Functionality of HSS-FE: Filtered Data Page
    [Tags]      TC06     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    wait for the page 	 HOME
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Traffic' link
    wait for the page 	 HSS-FE: Traffic
    validate the page title as		HSS-FE: Traffic
    verify buttons for Traffic HSS-FE      HSS-FE
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       6
    In KPIs section select    Location Query Requests (per sec)
    validate the title	  Node KPI Performance
    select nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    make selection in the 'KPI Details' graph

    click on button      HSS-FE: Filtered Data
    wait for the page 	 HSS-FE Filtered Data
    validate the page title as		HSS-FE Filtered Data

    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     hssfe_Location_Query_Requests
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
