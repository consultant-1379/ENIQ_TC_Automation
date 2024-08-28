*** Settings ***
Documentation     Verify the MRS: Platform and Capacity page
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

Verify the MRS: Platform page
    [Tags]      TC15     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'MRS: Platform >>' link
    wait for the page 	  MRS: Platform
    validate the page title as 	  MRS: Platform
    verify buttons for Capacity     MRS
    verify Time range and KPIs are displayed
    Click on the scroll down button     4    20
    In KPIs section select       CPU Load (%)
    validate the title	  Node KPI Performance
    select nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      MRS: Traffic
    wait for the page	 MRS: Traffic
    validate the page title as 	  MRS: Traffic
    click on button      MRS: Platform
    wait for the page 	  MRS: Platform
    validate the page title as 	  MRS: Platform
    click on button      MRS: Filtered Data
    wait for the page 	 MRS Filtered Data
    validate the page title as		MRS Filtered Data
    click on button      MRS: Platform
    wait for the page 	  MRS: Platform
    validate the page title as 	  MRS: Platform
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'MRS: Platform >>' link
    wait for the page 	  MRS: Platform
    validate the page title as 	  MRS: Platform
    Click on the scroll down button     4    20
    multiselect for KPI         CPU Load (%)    Processor Core CPU (%)
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button   
