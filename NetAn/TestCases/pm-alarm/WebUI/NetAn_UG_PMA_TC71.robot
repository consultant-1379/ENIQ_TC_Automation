*** Settings ***

Documentation     EQEV-110751 - Validate That The Connected Eniq Is Considered For Report Creation
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Validate That The Connected Eniq Is Considered For Report Fetching
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC71    EQEV-110751
    open pm alarm analysis
	Click on Administration button
	Navigate to section    ENIQ Connection Status	
	${dataSource}=    read the connectied ENIQ from ENIQ Connection Status page
	Click on minimise window button     0
	Navigate to the section    Home
	click on the button    Home
    Click on Alarm rules manager button
    Click on Create button
    verify that the connected ENIQ is present in "Select ENIQ data source" dropdown    ${dataSource}
    [Teardown]    Test teardown steps for pmalarm