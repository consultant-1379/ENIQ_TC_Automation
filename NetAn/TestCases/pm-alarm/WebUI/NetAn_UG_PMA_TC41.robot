*** Settings ***
Documentation	  EQEV-103914 Verify NetAn And ENIQ Connection Status is successfull in Administration Page
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

Verify NetAn And ENIQ Connection Status in Administration Page
	[Tags]      PMA_CDB          EQEV-103914      NetAn_UG_PMA_TC41
    open pm alarm analysis
    Navigate to Setup Data Source window
    verify that the connection to NetAn and ENIQ is made
    
          
    

   

    
    

    
    


    