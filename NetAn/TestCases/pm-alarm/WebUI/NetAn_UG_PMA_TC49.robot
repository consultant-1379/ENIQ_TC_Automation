*** Settings ***
Documentation	  EQEV-105271 Validate_Editing_A_Collection_With_A_Pre-Existing_Name
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
      

*** Test Cases ***

Validate Message Is Added In Edit Mode Node Collection Manager Page
	[Tags]    PMA_CDB     NetAn_UG_PMA_TC49    EQEV-105271
	run keyword and continue on failure    Validate Message Is Added In Edit Mode in Manager Page for Static Collection
	run keyword and continue on failure    Validate Message Is Added In Edit Mode in Manager Page for Dynamic Collection

*** Keywords ***


Validate Message Is Added In Edit Mode in Manager Page for Static Collection
	open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button    
    Click on Create collection button
    ${collection1}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button        
    Click on collection        ${collection1}
    Click on Edit collection button
    edit the collection name    ${collection}
    Click on Save button
    verify that a Collection with entered name already exists
    ${collection2}=     Enter Collection name         Collection_
    edit the collection name    ${collection2}
    Click on Save button
    Click on collection        ${collection2}

Validate Message Is Added In Edit Mode in Manager Page for Dynamic Collection
	open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Check the dynamic collection check-box
    Enter Wildcard Expression    FDN like '%ROOT%'
    Click on preview button
    Click on Create button    
    Click on Create collection button
    ${collection1}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Check the dynamic collection check-box
    Enter Wildcard Expression    FDN like '%ROOT%'
    Click on preview button
    Click on Create button        
    Click on collection        ${collection1}
    Click on Edit collection button
    edit the collection name    ${collection}
    Click on Save button
    verify that a Collection with entered name already exists
    ${collection2}=     Enter Collection name         Collection_
    edit the collection name    ${collection2}
    Click on Save button
    Click on collection        ${collection2}