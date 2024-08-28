*** Settings ***
Documentation     Verify the CSCF: Traffic page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/IMSCapacityWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify the CSCF:Traffic page
    [Tags]      TC04     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    click on the Reset button
    wait for the page 	 HOME
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Traffic' link
    wait for the page 	 CSCF: Traffic
    validate the page title as		CSCF: Traffic
    verify buttons for Traffic   CSCF
    Click on the scroll down button     1       8
    In KPIs section select       Call Attempts
    validate the title	  Node KPI Performance
    select CSCF nodes from 'Node KPI Performance' section
    validate the title 	  KPI Details
    click on button      CSCF: Platform and Capacity
    wait for the page 	  CSCF: Platform and Capacity
    validate the page title as 	  CSCF: Platform and Capacity
    click on button      CSCF: Traffic
    wait for the page	 CSCF: Traffic
    validate the page title as 	  CSCF: Traffic
    click on button      CSCF: Filtered Data
    wait for the page 	 CSCF Filtered Data
    validate the page title as		CSCF Filtered Data
    click on button      CSCF:Traffic
    wait for the page	 CSCF: Traffic
    validate the page title as 	  CSCF: Traffic
    click on button      IMS Node Overview
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    click on 'CSCF: Traffic' link
    wait for the page 	 CSCF: Traffic
    validate the page title as		CSCF: Traffic
    Click on the scroll down button     1       8
    multiselect for KPI    Call Attempts    Registered Users
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
