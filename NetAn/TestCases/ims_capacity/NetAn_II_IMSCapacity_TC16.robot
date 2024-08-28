*** Settings ***
Documentation     Verify the MRS: Traffic page
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

Verify the MRS:Traffic page
    [Tags]      TC16     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       20
    click on 'MRS: Traffic >>' link
    wait for the page 	 MRS: Traffic
    validate the page title as		MRS: Traffic
    verify buttons for Traffic without Capacity     MRS
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       9
    In KPIs section select       Call Setup Rate (per sec)
    validate the title	  Node KPI Performance
    select nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      MRS: Platform
    wait for the page 	  MRS: Platform
    validate the page title as 	  MRS: Platform
    click on button      MRS: Traffic
    wait for the page	 MRS: Traffic
    validate the page title as 	  MRS: Traffic
    click on button      MRS: Filtered Data
    wait for the page 	 MRS Filtered Data
    validate the page title as		MRS Filtered Data
    click on button      MRS: Traffic
    wait for the page	 MRS: Traffic
    validate the page title as 	  MRS: Traffic
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       20
    click on 'MRS: Traffic >>' link
    wait for the page 	 MRS: Traffic
    validate the page title as		MRS: Traffic
    Click on the scroll down button     2       9
    multiselect for KPI      Call Setup Rate (per sec)    Traffic Load (per sec)
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
