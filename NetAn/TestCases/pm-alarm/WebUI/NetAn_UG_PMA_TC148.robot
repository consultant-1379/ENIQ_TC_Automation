*** Settings ***

Documentation     Validate Edit And Delete Collection Buttons Must Be Disabled For Multiple Selections In The Table
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

Validate Edit And Delete Collection Buttons Must Be Disabled For Multiple Selections In The Table
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC148
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
	Validate that the collection is present in GUI    ${collection}
	Click on Create collection button
    ${collection1}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
	Validate that the collection is present in GUI    ${collection1}
	select multiple collections    ${collection1},${collection}
	verify that the edit button is disabled
	verify that the delete button is disabled
	[Teardown]    Test teardown steps for pmalarm