*** Settings ***

Documentation     EQEV-110751 - Verify That If Both DWHDB And REPDB Are Connected The Server Is Considered Connected
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

Verify That If Both DWHDB And REPDB Are Connected The Server Is Considered Connected
	[Tags]    PMA_CDB     NetAn_UG_PMA_TC86    EQEV-110751
    open pm alarm analysis
    Click on Administration button
	Navigate to the section    ENIQ Connection Status
    verify connection status in the DWHDB Connection Status
    verify connection status in the REPDB Connection Status
	[Teardown]    Test teardown steps for pmalarm