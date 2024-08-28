*** Settings ***
Documentation     Verify the Reset button on the Home Page
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


*** Test Cases ***

Verify the Functionality of the Reset button on Home Page
    [Tags]      TC21     IMS_CDB     IMS_KGB
    open ims capacity analysis
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Traffic >>' link
    wait for the page 	 SBG: Traffic
    validate the page title as		SBG: Traffic
    Click on the scroll down button    2    6
    In KPIs section select    Initial Registration Success (%)
    select SBG nodes from 'Node KPI Performance' section
    wait for the page 	 SBG: Traffic
    make selection in the 'KPI Details' graph
    click on button      SBG: Filtered Data
    wait for the page 	 SBG Filtered Data
    verify table is generated in Filtered Data page
    click on Home button if current its not in home page
    wait for the page 	 HOME
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    Click on the scroll down button     0       15
    click on 'SBG: Traffic >>' link
    wait for the page 	 SBG: Traffic
    validate the page title as		SBG: Traffic
    click on button      SBG: Filtered Data
    wait for the page 	 SBG Filtered Data
    Verify the Reset button has reset filters and markings
