*** Settings ***
Documentation     EQEV-103913 Verify if saving of Collection in NetAn DB is proper
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
      

*** Test Cases ***

Verify That Created Static and dynamic Collection Is Present In tblCollection
    [Tags]      PMA_CDB           EQEV-103913      NetAn_UG_PMA_TC37
	Run keyword and continue on failure      Verify That Created Static Collection Is Present In tblCollection
	Run keyword and continue on failure      Verify That Created Dynamic Collection Is Present In tblCollection   
    
    
          
    
*** keywords ***
Verify That Created Static Collection Is Present In tblCollection
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
    validate that the collection is present in NEtAn DB    ${collection}
	validate that the collection information is correct in NetAn DB         ${collection}		  Radio        NR
   

    
    
Verify That Created Dynamic Collection Is Present In tblCollection
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
	Click on Create button
    validate the page title    Node Collection Manager
    validate that the collection is present in GUI    ${collection}
    validate that the collection is present in NEtAn DB    ${collection}
	validate that the collection information is correct in NetAn DB         ${collection}		  Radio        NR
    
    


    