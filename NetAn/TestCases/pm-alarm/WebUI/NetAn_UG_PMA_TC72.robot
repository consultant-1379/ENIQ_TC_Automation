*** Settings ***

Documentation     EQEV-110751 - Validate That The Delete Button Is Disabled If Connection Is Not Selected
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

Validate That The Delete Button Is Disabled If Connection Is Not Selected
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC72    EQEV-110751
    open pm alarm analysis
	Click on Administration button
	Navigate to the section    Remove
    verify that the element is disabled    Remove
	[Teardown]    Test teardown steps for pmalarm