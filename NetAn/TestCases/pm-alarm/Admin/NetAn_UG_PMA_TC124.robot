*** Settings ***
Documentation     Validate Multi ENIQ Datasource Listed In Eniq Status Panel
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

Validate Multi ENIQ Datasource Listed In Eniq Status Panel	
	[Tags]      PMA        NetAn_UG_PMA_TC124
    open pm alarm analysis
	click on scroll down button    0    20
	Click on Administration button
	Connect to DB     localhost       netanserver      Ericsson01       NetAn_ODBC,4140_ODBC
    Validate ENIQ connections are displayed			NetAn_ODBC,4140_ODBC
         
    
  
    

    
    


    


    
    