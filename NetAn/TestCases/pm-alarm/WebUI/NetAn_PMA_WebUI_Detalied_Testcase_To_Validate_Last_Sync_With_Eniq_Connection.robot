*** Settings ***
Documentation     Testing Core Nodetypes
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
      

*** Test Cases ***

Validate Last Sync With Eniq Connection	
    open pm alarm analysis
	Click on Administration button
    click on scroll down button    0    20
    Click on maximise window button    1
    verify connection status in DWHDB Connection Status
    verify connection status in REPDB Connection Status and return
    verify Last Successful Sync With Eniq column Is Empty
         
    
  
    

    
    


    


    
    