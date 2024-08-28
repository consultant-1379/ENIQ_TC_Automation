*** Settings ***
Documentation     EniqName Values In Eniq Datasources And tblEniqDS Must Match
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

EniqName Values In ENIQ Datasources And tblEniqDS Must Match
	[TAGS]    PMEX_CDB    Admin_Page       NetAn_UG_PMEX_TC13
	open pm explorer analysis
	verify that the connected ENIQ is present in tblEniqDS    NetAn_ODBC
	change the mode to    Editing
	change to page navigation to    Titled tabs
	click on the button    Add new page
	check the show in user interface for tables    ENIQDataSources            20
	click on the button    Add new page
	click on the button    Start from data
	select the table ENIQDatasources for visualization
	click on the button    Add new page
	click on the button    Start from visualizations
	Change the Visualization type to Table
	select the table from Data table list    ENIQDataSources
	sleep    2
	validate that the connected datasource is present in ENIQDatasources
	Capture page screenshot
	