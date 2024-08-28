*** Settings ***
Documentation      EQEV-103913 Verify while creating a new collection default page is User-Defined collection page.
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

Validate while Collection Creation The Default Page Is User-Defined collection Page
    [Tags]     EQEV-103913      PMA_CDB       NetAn_UG_PMA_TC31
    open pm alarm analysis
    Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    validate the page title    Node Collection Manager
    validate that the collection is present in GUI    ${collection}
    
          
    

   

    
    

    
    


    