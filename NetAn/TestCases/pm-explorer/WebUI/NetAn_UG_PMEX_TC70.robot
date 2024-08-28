*** Settings ***
Documentation    Validate that After Sync with Eniq Measure Mapping Details are Updated
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  SikuliLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate that After Sync with Eniq Measure Mapping Details are Updated
    [Tags]       Admin_Page    PMEX_CDB       NetAn_UG_PMEX_TC70
	open pm explorer analysis	
	change the mode to    Editing
	change to page navigation to    Titled tabs
	go to the Page tab
	verify that the table has data
	Capture page screenshot
	