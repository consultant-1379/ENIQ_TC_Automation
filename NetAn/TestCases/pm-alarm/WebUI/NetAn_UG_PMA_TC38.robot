*** Settings ***
Documentation     EQEV-103914 Validate error message displayed for Eniq datasource connection failure in PMA admin page
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

Verify Connection Failure Message With Failed DataSource
    [Tags]      PMA_CDB           EQEV-103914      NetAn_UG_PMA_TC38
    open pm alarm analysis
    connect to the db    Failed_ODBC
    verify that the connection failed for Failed_ODBC