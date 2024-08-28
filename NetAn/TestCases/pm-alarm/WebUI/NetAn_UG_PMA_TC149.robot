*** Settings ***

Documentation     Verify The Subnetworks Are Listed In Subnetwork Viewer Panel On Node Collection Manager Page
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

Verify The Subnetworks Are Listed In Subnetwork Viewer Panel On Node Collection Manager Page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC149
    open pm alarm analysis
	verify that the SubNetwork List is not empty
	[Teardown]    Test teardown steps for pmalarm