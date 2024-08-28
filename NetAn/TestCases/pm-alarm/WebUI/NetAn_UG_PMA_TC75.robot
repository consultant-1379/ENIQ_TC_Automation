*** Settings ***

Documentation     EQEV-110751 - Validate That The Last Successful Sync With ENIQ Value Remains Same If We Run Sync With Eniq And Terminate It
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

Validate That The Last Successful Sync With ENIQ Value Remains Same If We Run Sync With Eniq And Terminate It
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC75    EQEV-110751
    open pm alarm analysis
    Click on Administration button
    navigate to the section    ENIQ Connection Status
    ${time}=    read the Last Successful Sync With Eniq value
    Click on minimise window button    0
    navigate to the section    Sync with ENIQ
	start sync with eniq and click on cancel
    Click on minimise window button    0
    navigate to the section    ENIQ Connection Status
    ${time1}=    read the Last Successful Sync With Eniq value
    should be equal    ${time}    ${time1}
	[Teardown]    Test teardown steps for pmalarm