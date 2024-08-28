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

Verify Creation Of vowifiConfig.ASCII File And It's Positioning In The ENIQ Server
    remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII
    create file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII    PARAMETER;VALUE
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII    \n
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII    NODEIDOFFSET;1000000	
	place the file in the directory    vowifiConfig.ASCII    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files    /eniq/data/pmdata/eniq_oss_1/vowifiConfig/
	verify the file placed in proper directory     vowifiConfig.ASCII    vowifiConfig
	
Verify that the directory and file have permissions required
    Check for the file permission    vowifiConfig.ASCII    vowifiConfig