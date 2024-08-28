*** Settings ***

Documentation     Verify That Create, Fetch Nodes, Import Nodes From File, Add >> And << Remove Buttons Are Disabled When We First Land On Collection Creation Page
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

Verify That Create, Fetch Nodes, Import Nodes From File, Add >> And << Remove Buttons Are Disabled When We First Land On Collection Creation Page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC151
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    verify that Add >> and << Remove buttons are disabled
	verify that the Import and Fetch Nodes buttons are disabled
	[Teardown]    Test teardown steps for pmalarm