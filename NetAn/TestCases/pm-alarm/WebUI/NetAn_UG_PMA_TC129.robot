*** Settings ***
Documentation     Verify Connection status column of Setup ENM connection for failed connection-if the Name/URL input field is empty
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

Verify Connection status column of Setup ENM connection for failed connection-if the Name/URL input field is empty
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC129	
    open pm alarm analysis
	Set up ENM connection with empty Name/URL
	Verify the message "please provide Value for: Server Name" is displayed in Connection status column		
    
         
    
  
    

    
    


    


    
    
