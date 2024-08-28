*** Settings ***
Documentation     Verify the HSS-FE: Traffic page
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

*** Test Cases ***

Verify the HSS-FE: Traffic page
    [Tags]      TC08     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Traffic' link
    wait for the page 	 HSS-FE: Traffic
    validate the page title as		HSS-FE: Traffic
    verify buttons for Traffic HSS-FE     HSS-FE
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       9
    In KPIs section select       Location Query Requests (per sec)
    validate the title	  Node KPI Performance
    select nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      HSS-FE:Platform and Capacity
    wait for the page 	  HSS-FE: Platform and Capacity
    validate the page title as 	  HSS-FE: Platform and Capacity
    click on button      HSS-FE: Traffic
    wait for the page	 HSS-FE: Traffic
    validate the page title as 	  HSS-FE: Traffic
    click on button      HSS-FE: Filtered Data
    wait for the page 	 HSS-FE Filtered Data
    validate the page title as		HSS-FE Filtered Data
    click on button      HSS-FE: Traffic
    wait for the page	 HSS-FE: Traffic
    validate the page title as 	  HSS-FE: Traffic
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS-FE: Traffic' link
    wait for the page 	 HSS-FE: Traffic
    validate the page title as		HSS-FE: Traffic
    Click on the scroll down button     2       9
    multiselect for KPI    User Authorization Query Requests (per sec)    User Location Success (%)
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
