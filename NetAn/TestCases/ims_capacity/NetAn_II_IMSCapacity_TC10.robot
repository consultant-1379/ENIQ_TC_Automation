*** Settings ***
Documentation     Verify the HSS: Filtered Data Page
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

Verify the Functionality of HSS: Filtered Data Page
    [Tags]      TC10     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    wait for the page 	 HOME
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS: Traffic >>' link
    wait for the page	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    verify buttons for Traffic  HSS
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       6
    In KPIs section select       Location Query Requests (per sec)
    validate the title	  Node KPI Performance
    select HSS nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    wait for the page	 HSS: Traffic
    make selection in the HSS 'KPI Details' graph
    click on button      HSS: Filtered Data
    wait for the page 	 HSS Filtered Data
    validate the page title as		HSS Filtered Data

    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     hss_Location_Query_Requests
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
