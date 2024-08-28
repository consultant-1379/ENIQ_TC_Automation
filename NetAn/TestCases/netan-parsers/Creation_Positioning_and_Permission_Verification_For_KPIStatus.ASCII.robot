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

Verify Creation Of ASCII file for configuring KPI_ID
    remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII
    create file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    KPI_ID;STATUS
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    \n
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    1;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    2;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    3;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    4;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    5;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    6;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    7;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    8;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    9;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    10;ACTIVE\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIStatus.ASCII    33;ACTIVE
	place the file in the directory    KPIStatus.ASCII    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files    /eniq/data/pmdata/eniq_oss_1/vowifiConfig/
	verify the file placed in proper directory     KPIStatus.ASCII    vowifiConfig
	
Verify that the directory and file have permissions required
    Check for the file permission    KPIStatus.ASCII    vowifiConfig