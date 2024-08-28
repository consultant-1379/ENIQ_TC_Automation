*** Settings ***

Documentation     Validate That The Create Button Is Disabled When Row Count In Selected Nodes Is 0
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

Validate That The Create Button Is Disabled When Row Count In Selected Nodes Is 0
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC153
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
    verify that the create button is disabled when row count in Selected Nodes is 0
	[Teardown]    Test teardown steps for pmalarm