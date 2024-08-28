*** Settings ***
Documentation	  EQEV-103914 Verify That The Connected ENIQ Is Present In Collection And Report Creation Pages
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

Verify That The Connected ENIQ Is Present In Collection And Report Creation
    [Tags]      PMA_CDB          EQEV-103914      NetAn_UG_PMA_TC44
    open pm alarm analysis    
    verify that the connected ENIQ is present in tblEniqDS    NetAn_ODBC
    Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Click on Create collection button
    validate the page title    Node Collection Manager
    validate that NetAn_ODBC is present in Node Collection Manager
    Click on Alarm rules manager button
    validate the page title    Alarm Rules Manager
    Click on Create button
    validate the page title    Alarm Rules Manager
    validate that NetAn_ODBC is present in Alarm Rules Manager
    
          
    

   

    
    

    
    


    
