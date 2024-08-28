*** Settings ***

Documentation     Verify That If Either DWHDB Or REPDB Are Connected Successfully The Server Is Connected
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

Verify That If Either DWHDB Or REPDB Are Connected Successfully The Server Is Connected
    [Tags]     Admin_Page    PMEX_CDB
	open pm explorer analysis
	Click on Administration button
	connect to the db
	${status1}=    verify connection status in DWHDB Connection Status and return
	${status2}=    verify connection status in REPDB Connection Status and return
	verify that the server is connected properly    ${status1}    ${status2}
	Capture page screenshot
	