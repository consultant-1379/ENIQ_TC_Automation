*** Settings ***
Documentation     EQEV-103914 Verify Error Message While Deleting A Failed DataSource
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

Verify Error Message While Deleting A Failed DataSource
    [Tags]      PMA_CDB            EQEV-103914      NetAn_UG_PMA_TC40
    open pm alarm analysis
    connect to the db    Failed_ODBC
    click on the failed ENIQ and click on delete    Failed_ODBC
    verify that no exception occurred while trying to delete Failed_ODBC
    
          
    

   

    
    

    
    


    