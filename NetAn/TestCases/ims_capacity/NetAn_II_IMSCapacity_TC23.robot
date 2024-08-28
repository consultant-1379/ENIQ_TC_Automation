*** Settings ***
Documentation     Verify the SBG: Filtered Data Page
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

Verify the Functionality of SBG: Filtered Data Page
    [Tags]      TC23     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Traffic >>' link
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic
    verify buttons for Traffic without Capacity      SBG
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       6
    In KPIs section select       Initial Registration Success (%)
    verify table is generated in Filtered Data page
    validate the title	  Node KPI Performance
    select SBG nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    make selection in the 'KPI Details' graph
    click on button      SBG: Filtered Data
    wait for the page 	 SBG Filtered Data
    validate the page title as		SBG Filtered Data
    
    ${measureValue}    ${nodeName}    ${dateTime}=    record NodeName & DateTime of first raw from the UI for SBG
    ${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/ims-capacity/dataIntegrity.json     sbg_Initial_Registration_Success
    ${DB_Value}=    query the eniq database for    ${sql_query}    ${nodeName}    ${dateTime}
    Compare UI with DB value    ${measureValue}     ${DB_Value}
