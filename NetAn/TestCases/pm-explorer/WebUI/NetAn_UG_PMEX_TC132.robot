*** Settings ***
Documentation     Validate Error Message When NetAn Database Is Not Connecting In Administration Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Error Message When NetAn Database Is Not Connecting In Administration Page
    [Tags]      PMEX_CDB    Admin_Page
	open pm explorer analysis
	click on the scroll down button    0     20
	click on the button      Administration
	click on the scroll down button    0    15
	Connect to ENIQ with incorrect Credentials
    Capture page screenshot
	