*** Settings ***
Documentation     Validate that After Sync with Eniq SubNetwork Details are Updated
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  SikuliLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate that After Sync with Eniq SubNetwork Details are Updated
    [Tags]     PMEX_CDB          Admin_Page       NetAn_UG_PMEX_TC71
	open pm explorer analysis
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	check the show in user interface for tables    SubNetwork List    12
    click on the button    Add new page
	click on the button    Start from data
	select the table SubNetwork List for visualization
	click on the button    Start from visualizations
	Change the Visualization type to Table
	select the table from Data table list    SubNetwork List
	verify that the table has data
	Capture page screenshot
	