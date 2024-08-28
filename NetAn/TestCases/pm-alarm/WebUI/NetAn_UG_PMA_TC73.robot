*** Settings ***

Documentation     EQEV-110751 - Validate That The Last Successful Sync With ENIQ Time Is The Server Time
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

Validate That The Last Successful Sync With ENIQ Time Is The Server Time
	[Tags]    PMA_CDB     NetAn_UG_PMA_TC73    EQEV-110751
    open pm alarm analysis
    Click on Administration button
	Click on Sync with Eniq
	Navigate to the section    ENIQ Connection Status
    ${time}=    read the Last Successful Sync With Eniq value
    verify that the Time read from Eniq DS table is the server's time    ${time}
    [Teardown]    Test teardown steps for pmalarm