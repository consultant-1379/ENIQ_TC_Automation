*** Settings ***
Documentation     Verify Multi ENIQ Datasource For Successful Configuration and Verify Remove button is disbled for multiple eniq
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

Validate Multi ENIQ Datasource For Successful Configuration	
    [Tags]      PMA_CDB        NetAn_UG_PMA_TC122	
    open pm alarm analysis
	Click on Administration button
    Connect to eniq and validate message           NetAn_ODBC,4140_ODBC            Connected
    Verify Remove button is disbled for multiple eniq         NetAn_ODBC,4140_ODBC
         
    
  
    

    
    


    


    
    