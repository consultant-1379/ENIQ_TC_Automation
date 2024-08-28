*** Settings ***

Documentation     Validate if MO Class Filter values are listed based on Datasource selection
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

*** Test Cases ***
Validate if MO Class Filter values are listed based on Datasource selection
    [Tags]       PMEX_CDB       Report_Manager
    open pm explorer analysis
    change the mode to    Editing
	change to page navigation to    Titled tabs
	#click on the button    Add new page
	check the show in user interface for tables    MoClass    24
    Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes as       ERBS1
    Click on scroll down button     6    20
    Select the Aggregation    No Aggregation
    Select All values in MO Class
    click on the button    Add new page
	click on the button    Start from data
	select the table MoClass for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table    
	select the table from Data table list    MoClass
    Verify that there's data in the MOClass table
    Capture page screenshot