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

Verify Creation Of ASCII file for configuring KPIThreshold
    remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII
    create file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    KPI_ID;THRESHOLD
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    \n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    1;95\n
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    2;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    3;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    4;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    5;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    6;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    7;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    8;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    9;95\n
	append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\KPIThreshold.ASCII    10;95\n
	place the file in the directory    KPIThreshold.ASCII    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files    /eniq/data/pmdata/eniq_oss_1/vowifiConfig/
	verify the file placed in proper directory     KPIThreshold.ASCII    vowifiConfig
	
Verify that the directory and file have permissions required
    Check for the file permission    KPIThreshold.ASCII    vowifiConfig