*** Settings ***
Documentation     Validate Multi ENIQ Datasource Connection For Dwhdb And Repdb. connection to REPDB failed and server is considered failed
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

Validate Multi ENIQ Datasource Connection For Dwhdb And Repdb
    [Tags]      PMA_CDB        NetAn_UG_PMA_TC121	
    open pm alarm analysis
    click on scroll down button    0    20
	Click on Administration button
    verify that connection to REPDB failed and server is considered failed
         
    
  
    

    
    


    


    
    