*** Settings ***

Library           Selenium2Library
Library           OperatingSystem
Library     	  SSHLibrary
Library     	  DateTime
Library     	  String
Library     	  Collections
Library     	  Selenium
Library           DatabaseLibrary
Library			  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Scripts/IronPythonScripts/Fileupload.py
Resource		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/ParserKeywords.robot
Resource		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Resource		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Test Setup    	  Connect to server as a dcuser
Test Teardown     Test Teardown steps
    

*** Test Cases ***

Set The Log Level To Finest 
	open the adminui page    
	click on button     Logging Configuration
	verify the page title    Logging Configuration
	Trigger the interfaces
	save the changes made
    [Teardown]    Test Teardown steps