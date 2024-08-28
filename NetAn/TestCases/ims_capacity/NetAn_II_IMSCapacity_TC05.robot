*** Settings ***
Documentation     Verify the HSS-FE: Filtered Data Page For Platform and Capacity
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
Verify the Functionality of HSS-FE: Filtered Data For Platform and Capacity Page
    [Tags]      TC05     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    wait for the page 	 HOME
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Platform and Capacity >>' link
    wait for the page 	  HSS-FE: Platform and Capacity
    validate the page title as 	  HSS-FE: Platform and Capacity
    verify Time range and KPIs are displayed
    Click on the scroll down button     3       20
    In KPIs section select       CPU Load (%)
    validate the title	  Node KPI Performance
    select HSS-FE nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    wait for the page 	  HSS-FE: Platform and Capacity
    make selection in the HSS-FE 'KPI Details' graph
    click on button      HSS-FE: Filtered Data
    wait for the page 	 HSS-FE Filtered Data
    validate the page title as		HSS-FE Filtered Data

    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for HSS-FE
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     hssfe_CPU_Load
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
