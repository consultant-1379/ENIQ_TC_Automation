*** Settings ***
Documentation     Verify If All Fields Are Empty When the Value of ENIQ Data Source is Changed
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}


*** Test Cases ***

Verify If All Fields Are Empty When the Value of ENIQ Data Source is Changed
    [Tags]     PMEX_CDB          Report_Manager
    open pm explorer analysis	
    Click on Administration button
    Connect to DB
    go to Home page
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    NR
    Verify if all fields are empty when the value of ENIQ data source is changed    NetAn_ODBC    4140_ODBC
    Capture page screenshot
	