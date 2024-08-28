*** Settings ***

Documentation     Validate Eniq Datasource table for Multiple ENIQs
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

*** Test Cases ***

Validate Eniq Datasource table for Multiple ENIQs
    [Tags]     PMEX_CDB           Admin_Page    NetAn_UG_PMEX_TC53
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	connect to the database with empty DataSource
	connect to Multiple ENIQs
	verify that Remove button is disabled for multiple selections in DataSources
	Connect to Failed DB
	verify that the connection to NetAn database is made
	verify that the connection failed for one datasource
    Capture page screenshot
	