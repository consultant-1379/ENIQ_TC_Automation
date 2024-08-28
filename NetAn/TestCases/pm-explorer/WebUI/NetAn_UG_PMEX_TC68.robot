*** Settings ***

Documentation     Validate if Error Message is Displayed for Incorrect Credentials
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

Validate if Error Message is Displayed for Incorrect Credentials
	[Tags]       PMEX_CDB        Admin_Page      NetAn_UG_PMEX_TC68
	open pm explorer analysis
	Click on Administration button
	validate the page title    Administration
	Connect to ENIQ with incorrect Credentials
	verify that connection is not made
	Capture page screenshot