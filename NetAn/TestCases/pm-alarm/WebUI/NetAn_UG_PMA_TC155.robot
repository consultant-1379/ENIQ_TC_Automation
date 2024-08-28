*** Settings ***

Documentation     Verify The Alert Message Should Be Hidden For Node Type And System Area Dropdown When Their Dropdowns Have Value
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

Verify The Alert Message Should Be Hidden For Node Type And System Area Dropdown When Their Dropdowns Have Value
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC155
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    Select ENIQ Data Source in collection manager        NetAn_ODBC
	Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    verify that system area is selected and alert message is not visible
	verify that node type is selected and alert message is not visible
	[Teardown]    Test teardown steps for pmalarm