*** Settings ***

Documentation     Validate Add >> And Remove << Should Be Disbaled Before Clicking On Fetch Nodes
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

Validate Add >> And Remove << Should Be Disbaled Before Clicking On Fetch Nodes
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC152
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    verify that Add >> and << Remove buttons are disabled
	Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
	Select Nodes in collection manager       G2RBS01
	verify that Add >> and << Remove buttons are enabled
	[Teardown]    Test teardown steps for pmalarm