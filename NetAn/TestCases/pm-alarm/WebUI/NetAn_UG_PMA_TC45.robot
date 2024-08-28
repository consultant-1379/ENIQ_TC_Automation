*** Settings ***
Documentation	  EQEV-103914 Verify That The Connected ENIQ Is Present In tblEniqDS
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

Verify That The Connected ENIQ Is Present In tblEniqDS
    [Tags]      PMA_CDB          EQEV-103914      NetAn_UG_PMA_TC45
	open pm alarm analysis
    Navigate to Setup Data Source window
    verify that the connection to NetAn and ENIQ is made
    Click on minimise window button    0   
    Validate ENIQ connections are displayed    NetAn_ODBC
    verify that the connected ENIQ is present in tblEniqDS    NetAn_ODBC
    
          
    

   

    
    

    
    


    