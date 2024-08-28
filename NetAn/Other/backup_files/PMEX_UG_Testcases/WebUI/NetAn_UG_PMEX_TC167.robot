*** Settings ***
Documentation     Testing Sync with operation successful by verifying the Eniq DataSrouce in Modified Topology Data and in SubNetwork List table
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

Validate That The Connected DataSource Is Updated In Both SubNetwork List And Modified Topology Table
    [Tags]     PMEX_CDB      Admin_Page
	open pm explorer analysis
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	check the show in user interface for tables      Modified Topology Data      12
	check the show in user interface for tables      SubNetwork List        0
	click on the button    Add new page																
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
	read DataSourceName in SubNework List table	   ${dataSource1}
	Capture page screenshot

 