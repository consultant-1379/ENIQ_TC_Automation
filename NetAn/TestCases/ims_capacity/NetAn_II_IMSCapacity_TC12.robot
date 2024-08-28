*** Settings ***
Documentation     Verify the HSS: Traffic page
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

Verify the HSS:Traffic page
    [Tags]      TC12     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS: Traffic >>' link
    wait for the page	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    verify buttons for Traffic      HSS
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       10
    In KPIs section select       Location Query Requests (per sec)
    validate the title	  Node KPI Performance
    select HSS nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      HSS: Platform and Capacity
    wait for the page	 HSS: Platform and Capacity
    validate the page title as 	  HSS: Platform and Capacity
    click on button      HSS: Traffic
    wait for the page	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    click on button      HSS: Filtered Data
    wait for the page 	 HSS Filtered Data
    validate the page title as		HSS Filtered Data
    click on button      HSS:Traffic
    wait for the page	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'HSS: Traffic >>' link
    wait for the page	 HSS: Traffic
    validate the page title as 	  HSS: Traffic
    Click on the scroll down button     2       10
    multiselect for KPI    User Authorization Query Requests (per sec)    User Location Success (%)
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
