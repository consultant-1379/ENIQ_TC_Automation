*** Settings ***
Documentation     Verify the SBG: Platform and Capacity page
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

Verify the SBG: Platform page
    [Tags]      TC24     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Platform >>' link
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform
    verify buttons for Capacity     SBG
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       7
    In KPIs section select       CPU Load (%)
    validate the title	  Node KPI Performance
    select SBG nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      SBG: Traffic
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic
    click on button      SBG: Platform
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform
    click on button      SBG: Filtered Data
    wait for the page 	 SBG Filtered Data
    validate the page title as		SBG Filtered Data
    click on button      SBG: Platform
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Platform >>' link
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform
    Click on the scroll down button     2       7
    multiselect for KPI    CPU Load (%)    Memory Usage (%)
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button    
