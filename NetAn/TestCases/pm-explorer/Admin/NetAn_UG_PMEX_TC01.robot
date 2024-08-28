*** Settings ***
Documentation     Check Functionality Of Sync_With_Eniq With No Data In Modified_Topology_Data Table
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Check Functionality Of Sync With Eniq With No Data In Modified Topology Data Table
    [TAGS]    PMEX_CDB      Admin_Page       NetAn_UG_PMEX_TC01
	open pm explorer analysis
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	check the show in user interface for tables    Modified Topology Data
	click on the button    Add new page
	click on the button    Start from data
	select the table Modified Topology Data for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table    
	select the table from Data table list    Modified Topology Data
	${dataSource1}=    read DataSourceName in Modified Topology Data table		
	click on the back button    20
	click on the button    Administration
	validate the error message in Sync With Eniq
	Capture page screenshot