*** Settings ***
Documentation     Testing the Listing of System Area and Node Type based on Data Source selected
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate That System Area And Node Type Are Listed Based On DataSource
    [Tags]      PMEX_CDB        Report_Manager
	open pm explorer analysis
	Click on Report manager button
	Click on Create button
	Select ENIQ DataSource    NetAn_ODBC
	Select the System area    Radio
	Select Node type    ERBS
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	click on the button    Start from data
	select the table Measure Mapping for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	verify that there's data in the Measure Mapping table
	Capture page screenshot

 