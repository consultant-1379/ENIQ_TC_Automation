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

Verify all the readable permissions are given for INTF_CV_SGSN_MME
    execute the command     cd /eniq/data/pmdata/eniq_oss_1/InformationStore/dc_cv_sgsn_mme
	${file_name}=    execute the command     ls
	Check for the file permission    ${file_name}    InformationStore/dc_cv_sgsn_mme