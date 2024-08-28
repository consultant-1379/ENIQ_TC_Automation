*** Settings ***
Documentation     Verify the MTAS: Filtered Data Page For Platform and Capacity
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
Verify the Functionality of MTAS: Filtered Data For Platform and Capacity Page
    [Tags]      TC17     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       20
    click on 'MTAS: Platform and Capacity >>' link
    wait for the page	 MTAS:Platform and Capacity
    validate the page title as 	  MTAS:Platform and Capacity
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       9
    In KPIs section select       Active Users
    validate the title	  Node KPI Performance
    validate the title 	  KPI Details
    select MTAS nodes from 'Node KPI Performance' section
    make selection in the 'KPI Details' graph
    click on button      MTAS: Filtered Data
    wait for the page 	 MTAS Filtered Data
    validate the page title as		MTAS Filtered Data

    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MTAS
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     mtas_Active_Users
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
