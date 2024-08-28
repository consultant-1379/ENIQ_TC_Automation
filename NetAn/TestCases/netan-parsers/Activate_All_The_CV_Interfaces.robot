*** Settings ***

Library           Selenium2Library
Library           SeleniumLibrary
Library           OperatingSystem
Library     	  SSHLibrary
Library     	  DateTime
Library     	  String
Library     	  Collections
Library     	  Selenium
Library			  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Scripts/IronPythonScripts/Fileupload.py
Resource		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/ParserKeywords.robot
Test Setup    	  Connect to server as a dcuser
Test Teardown     Close All Connections

*** Test Cases ***

Activate Interface from Putty for CV_INFORMATION_STORE
	Fileupload.filePasteAndActivateInterface