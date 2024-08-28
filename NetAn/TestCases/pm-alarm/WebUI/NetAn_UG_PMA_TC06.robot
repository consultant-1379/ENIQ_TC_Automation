*** Settings ***
Documentation     Validate Delete button in Collection Manager page
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

Validate Delete button in Collection Manager page
	[Tags]      PMA_CDB      EQEV-126953
    open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on scroll down button    0    15
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    Close Browser
    open pm alarm analysis with another username
    Click on Node Collection manager button
    place the cursor on    CollectionName
    Click on scroll up button    1    30
    Delete the collection and verify collection is removed    ${collection}
    capture page screenshot
             
    
  
    

    
    

    
    


    
    