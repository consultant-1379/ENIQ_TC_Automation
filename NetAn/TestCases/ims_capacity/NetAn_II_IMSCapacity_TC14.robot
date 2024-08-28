*** Settings ***
Documentation     Verify the MRS: Filtered Data page
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

Verify the Functionality of MRS: Filtered Data Page
    [Tags]      TC14     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    wait for the page 	 HOME
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'MRS: Traffic >>' link
    wait for the page 	 MRS: Traffic
    validate the page title as		MRS: Traffic
    verify buttons for Traffic without Capacity     MRS
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       6
    In KPIs section select    Call Setup Rate (per sec)
    verify table is generated in Filtered Data page
    validate the title	  Node KPI Performance
    select MRS nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    make selection in the 'KPI Details' graph

    click on button      MRS: Filtered Data
    wait for the page 	 MRS Filtered Data
    validate the page title as		MRS Filtered Data

    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for MRS
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     mrs_Call_Setup_Rate
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
