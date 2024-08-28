*** Settings ***
Documentation     Verify the Node Overview Page: IMS Capacity Analysis
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

Verify the Node Overview page Page: IMS Capacity Analysis
    [Tags]      TC28     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    validate the page title as     HOME
    click on the Settings button
    wait for the page 	 Settings
    validate the page title as      Settings
    back to home page
    wait for the page 	 HOME 
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
    Summary of node type should be visible in table		CSCF    HSS		HSS-FE		MRS		 MTAS		SBG		Node Type		Hardware Details		Utilization		Analysis		No. of Nodes		Node Versions		No. of Processors		No. of Registered Users (Avg)     CPU Load (Avg)     Memory Usage (Avg)
    check Navigation button for each node type     CSCF: Platform and Capacity >>     CSCF: Traffic >>     HSS: Platform and Capacity >>     HSS: Traffic >>     HSS-FE: Platform and Capacity >>     HSS-FE: Traffic >>     MRS: Platform >>     MRS: Traffic >>     MTAS: Platform and Capacity >>     MTAS: Traffic >>     SBG: Platform >>     SBG: Traffic >>    
    Go to home page if not already at home
    wait for the page 	 HOME
    validate the page title as     HOME
    capture page screenshot
