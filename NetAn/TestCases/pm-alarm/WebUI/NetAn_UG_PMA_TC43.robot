*** Settings ***
Documentation     EQEV-103914 Verify That An Exception Is Thrown If We're Trying To Connect An ENIQ While NetAn Is Not Connected
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

Verify That An Exception Is Thrown If We're Trying To Connect An ENIQ While NetAn Is Not Connected
    [Tags]      PMA_CDB          EQEV-103914      NetAn_UG_PMA_TC43
	open pm alarm analysis    
    connect to the db    4140_ODBC
    Connect to ENIQ with No Password    localhost       netanserver      Ericsson0    NetAn_ODBC        
    enter the datasource    NetAn_ODBC
    click on the connect button to connect ENIQ DB
    verify that an error occurred while trying to add a DataSource without connecting to NETAN
    verify that an error occurred while trying to add a DataSource
    
          
    

   

    
    

    
    


    