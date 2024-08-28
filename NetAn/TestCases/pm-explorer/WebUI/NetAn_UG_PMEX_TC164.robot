*** Settings ***
Documentation     SubNetwork List Table Is Updated With The DataSource Connected In Modified Topology Table
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

SubNetwork List Table Is Updated With The DataSource Connected In Modified Topology Table
    [Tags]     PMEX_CDB      Admin_Page
	open pm explorer analysis
	verify that the connected ENIQ is present in tblEniqDS    NetAn_ODBC
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	check the show in user interface for tables      Modified Topology Data        10
	check the show in user interface for tables      SubNetwork List         9
	click on the button    Start from data
	select the table Modified Topology Data for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	${dataSource1}=    read DataSourceName in Modified Topology Data table	
	click on the button    Add new page
	click on the button    Start from data
	select the table SubNetwork List for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	${dataSource2}=    read the DataSourceName in SubNework List table
	the dataSources from the above 2 tables should match     ${dataSource1}    ${dataSource2}
	Capture page screenshot
	
	

 