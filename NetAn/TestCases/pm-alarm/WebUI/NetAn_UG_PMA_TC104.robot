*** Settings ***

Documentation     Validate That The Netan Server Time, Timezone And Date Should Be Visible In Analysis Instead Of Local Server
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

Validate That The Netan Server Time, Timezone And Date Should Be Visible In Analysis Instead Of Local Server
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC104
    open pm alarm analysis
    Connect to DB and sync with eniq
    navigate to section    ENIQ Connection Status
    ${time}=    read the Last Successful Sync With Eniq value
    verify that the Time read from Eniq DS table is the server's time    ${time}
	[Teardown]    Test teardown steps for pmalarm