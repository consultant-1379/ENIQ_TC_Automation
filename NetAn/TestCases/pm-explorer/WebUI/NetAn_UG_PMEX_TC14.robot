*** Settings ***
Documentation     Validate SubNetwork Is Refreshed For Failed DataSources
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

Validate SubNetwork Is Refreshed For Failed DataSources
    [Tags]     PMEX_CDB   Admin_Page      NetAn_UG_PMEX_TC14
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	Connect to Multiple ENIQs
	click on Sync with Eniq
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	check the show in user interface for tables      SubNetwork List      9
	check the show in user interface for tables      Modified Topology Data      10
	check the show in user interface for tables      ENIQDataSources      16
	click on the button    Start from data
	select the table ENIQDatasources for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	select the table ENIQDatasources in visualization      4
	${dataSource1}    ${dataSource2}=    read the EniqName column values in ENIQDatasources
	click on the button    Add new page
	click on the button    Start from data
	select the table Modified Topology Data for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	${modifiedTopologyDS}=    read the DatasourceName column values in Modified Topology Data
	click on the button    Add new page
	click on the button    Start from data
	select the table SubNetwork List for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	read the DataSourceName column values in SubNework List table    ${dataSource1}    ${dataSource2}    ${modifiedTopologyDS}
	Capture page screenshot
	