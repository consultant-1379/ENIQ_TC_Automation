*** Settings ***
Documentation     Validate Multi ENIQ Datasource Successful Connection If Input Field Is Empty
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

Validate Multi ENIQ Datasource Successful Connection If Input Field Is Empty
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC125	
    open pm alarm analysis
	Click on Administration button
    Connect to DB     localhost       netanserver      Ericsson01       ${EMPTY}
	Validate ENIQ connections are displayed			NetAn_ODBC,4140_ODBC
         
    
  
    

    
    


    


    
    