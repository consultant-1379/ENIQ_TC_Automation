*** Settings ***
Documentation     Verify the SBG: Traffic page
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

Verify the SBG : Traffic page
    [Tags]      TC25     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Traffic >>' link
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic
    verify buttons for Traffic without Capacity   SBG
    verify Time range and KPIs are displayed
    Click on the scroll down button     2       9
    In KPIs section select       Initial Registration Success (%)
    validate the title	  Node KPI Performance
    select SBG nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      SBG: Platform
    wait for the page	 SBG: Platform
    validate the page title as 	  SBG: Platform
    click on button      SBG: Traffic
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic
    click on button      SBG: Filtered Data
    wait for the page 	 SBG Filtered Data
    validate the page title as		SBG Filtered Data
    click on button      SBG: Traffic
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Traffic >>' link
    wait for the page	 SBG: Traffic
    validate the page title as 	  SBG: Traffic
    Click on the scroll down button     2       9
    multiselect for KPI    Reregistration Success (%)    Mean Holding Time (s)
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
