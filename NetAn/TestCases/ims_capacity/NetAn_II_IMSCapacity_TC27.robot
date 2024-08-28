*** Settings ***
Documentation     Verify the HOME Page: IMS Capacity Analysis
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

Verify the HOME Page: IMS Capacity Analysis
    [Tags]      TC27     IMS_CDB     IMS_KGB
    open ims capacity analysis
    Go to home page if not already at home
    wait for the page 	 HOME
    validate the page title as     HOME
    verify that the IMS Node Overview button is present
    verify that the Settings button is present
    verify that the Reset button is present
    click on the Settings button
    wait for the page 	 Settings
    validate the page title as      Settings
    back to home page
    wait for the page 	 HOME 
    click on the Reset button
    click on the IMS Node Overview button
    wait for the page 	 IMS Node Overview
    validate the page title as 	  IMS Node Overview
