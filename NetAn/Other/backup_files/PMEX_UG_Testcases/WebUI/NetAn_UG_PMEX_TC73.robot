*** Settings ***
Documentation     Validate_that_Error_is_Shown_if_Measures_are_not_Selected_During_Report_Creation
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  SikuliLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate_that_Error_is_Shown_if_Measures_are_not_Selected_During_Report_Creation
    [Tags]      PMEX_CDB         Report_Manager          NetAn_UG_PMEX_TC73
	open pm explorer analysis 
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCDM
    Select Get Data For    Node(s)
    Select the Aggregation    No Aggregation
    Click on Refresh nodes button
    Select Nodes    CCDM01
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     Day  
    ${IsElementInteractable}=    Run Keyword And Return Status    click on button    Fetch PM Data
    verify that the element is not interactable    ${IsElementInteractable}    
	Capture page screenshot
	