*** Settings ***

Documentation     Validate 'Sync with Eniq' button with empty datasource
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

Validate 'Sync with Eniq' button with empty datasource
	[Tags]       PMEX_CDB       Admin_Page      NetAn_UG_PMEX_TC02
    open pm explorer analysis
    Click on Administration button
    validate the page title    Administration
    validate the error message in Sync With Eniq
    Capture page screenshot