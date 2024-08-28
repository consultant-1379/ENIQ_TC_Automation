*** Settings ***
Documentation     Verify the MTAS: Platform and Capacity page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/IMSCapacityWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Verify the MTAS: Platform and Capacity page
    [Tags]      TC19     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       20
    click on 'MTAS: Platform and Capacity >>' link
    wait for the page	 MTAS:Platform and Capacity
    validate the page title as 	  MTAS:Platform and Capacity
    verify buttons for Capacity     MTAS
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       9
    In KPIs section select       Memory Usage (%)
    validate the title	  Node KPI Performance
    validate the title 	  KPI Details
    click on button      MTAS: Traffic
    wait for the page	 MTAS: Traffic
    validate the page title as 	  MTAS: Traffic
    click on button      MTAS: Platform and Capacity
    wait for the page	 MTAS:Platform and Capacity
    validate the page title as 	  MTAS:Platform and Capacity
    click on button      MTAS: Filtered Data
    wait for the page 	 MTAS Filtered Data
    validate the page title as		MTAS Filtered Data
    click on button      MTAS: Platform and Capacity
    wait for the page	 MTAS:Platform and Capacity
    validate the page title as 	  MTAS:Platform and Capacity
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       20
    click on 'MTAS: Platform and Capacity >>' link
    wait for the page	 MTAS:Platform and Capacity
    validate the page title as 	  MTAS:Platform and Capacity
    Click on the scroll down button     2       9
    multiselect for KPI    CPU Load (%)    Active Users
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
