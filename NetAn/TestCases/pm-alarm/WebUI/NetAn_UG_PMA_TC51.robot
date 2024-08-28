*** Settings ***

Documentation	  EQEV-105271 - Verify That A Message Is Added In Edit Mode In Node Collection Manager Page
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

Validate Message Is Added In Edit Mode Node Collection Manager Page
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC51    EQEV-105271
    open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
	Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01,G2RBS04
    Click on Create button
    Click on collection        ${collection}
    Click on Edit collection button
    Check the dynamic collection check-box
    Enter Wildcard Expression    FDN like '%ROOT%'
    validate that the message is present
    Click on Save button
	[Teardown]    Test teardown steps for pmalarm