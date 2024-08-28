*** Settings ***

Documentation     Validate If Node List is Displaying Nodes for Selected SubNetwork
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  AutoItLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate If Node List is Displaying Nodes for Selected SubNetwork
	[Tags]       PMEX_CDB        Report_Manager     NetAn_UG_PMEX_TC55
    open pm explorer analysis
    Click on Report manager button   
    validate the page title    Report Manager
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Core
    Select Node type    CCES
    Click on scroll down button    6    15
    Select Get Data For as    SubNetwork
    verify list box is not empty
    Capture page screenshot