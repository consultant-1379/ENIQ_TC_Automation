*** Settings ***

Documentation     EQEV-110751 - Validate Sync With Eniq Execution Date Time And Timezone Is Displayed In Settings Page UI
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

Validate Sync With Eniq Execution Date Time And Timezone Is Displayed In Settings Page UI
	[Tags]    PMA_CDB     NetAn_UG_PMA_TC70    EQEV-110751
    open pm alarm analysis
    Click on Administration button
	Navigate to section    ENIQ Connection Status	
    ${dateTime}=    read the Last Successful Sync With Eniq value
    verify the time and timezone in Last Successful Sync    ${dateTime}
    [Teardown]    Test teardown steps for pmalarm