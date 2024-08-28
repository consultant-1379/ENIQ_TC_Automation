*** Settings ***
Documentation     EQEV-126953 Verify That A Collection Can Be Edited If Its created by another user
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

Verify That A Collection Can Be Edited If Its created by another user
    [Tags]      PMA_CDB      EQEV-126953          NetAn_UG_PMA_TC32
    open pm alarm analysis with another username
    Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Click on Create collection button
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
	Verify error message when creating the alarm without collection name
    ${collection}=     Enter Collection name         Collection_	
    Click on Create button
    validate the page title    Node Collection Manager
    Close Browser
    open pm alarm analysis
    Click on Node Collection manager button
    Click on collection        ${collection}
    Click on Edit collection button
    validate the page title    Node Collection Manager
	Verify error message when saving the alarm without collection name
	Click on Cancel button in edit page
    Click on collection        ${collection}
    Click on Edit collection button
    validate the page title    Node Collection Manager
	Select Access Type
    Check the dynamic collection check-box
    Enter the WildcardExpression      FDN like '%Root%'
    Click on preview button
    Click on save button
    validate the page title    Node Collection Manager
	Verify ModifiedBy column is updated to        Administrator        ${collection}
    capture page screenshot
