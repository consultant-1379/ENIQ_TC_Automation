*** Settings ***

Documentation     Validate That Modifiedby Column Is Empty After Creation Of Static Collection
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

Validate That Modifiedby Column Is Empty After Creation Of Static Collection
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC161
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
	verify that ModifiedBy column is empty    ${collection}
	[Teardown]    Test teardown steps for pmalarm