*** Settings ***
Documentation     EQEV-103913 While editing a System-Defined collection, fields are filled with proper values in newly added page.
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

Validate While Editing A Collection The FIelds Are Filled With Proper Values
    [Tags]     PMA_CDB      EQEV-103913      NetAn_UG_PMA_TC34
    open pm alarm analysis
    Click on Node Collection manager button
	Verify edit collection and delete collection buttons are disabled when no collection selected
    validate the page title    Node Collection Manager
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Check the dynamic collection check-box
    Enter the Wildcard Expression    FDN like '%ROOT%'
	verify that Preview section is empty
    Click on preview button
    verify that nodes are visible in Preview section