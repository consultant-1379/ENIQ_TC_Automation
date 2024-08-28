*** Settings ***

Documentation     Verify The Alert Message Should Be Enabled For Node Type And System Area Dropdown When Dropdown Value Is Empty
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Verify The Alert Message Should Be Enabled For Node Type And System Area Dropdown When Dropdown Value Is Empty
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC154
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    verify that no system area is selected and alert message is visible
	verify that no node type is selected and alert message is visible
	[Teardown]    Test teardown steps for pmalarm