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
Test Teardown     Close All Connections

*** Test Cases ***

Parse file for INTF_CV_MTAS_MTAS
    execute the command     cd /eniq/data/pmdata/eniq_oss_1/InformationStore/dc_cv_mtas_mtas/
    ${file_name}=    execute the command     ls
    remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\${file_name}
    ${date}=    Get Current Date    result_format=%Y%m%d_%H%M
    create file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\${date}.txt    ${date}
    place the file in the directory    ${date}.txt    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files    /eniq/data/pmdata/eniq_oss_1/InformationStore/dc_cv_mtas_mtas/
	open the adminui page
	click on button    ETLC Set Scheduling
	verify the page title    ETLC Set Scheduling
	select the type    Interface
	select the package    INTF_CV_MTAS_MTAS-eniq_oss_1
	click on button    ETLC Set History
	click on the button    Search
	click on link	Adapter_INTF_CV_MTAS_MTAS_information_store_parser
	sleep    20
	Verify the parser logs    dc_cv_mtas_mtas    INTF_CV_MTAS_MTAS-eniq_oss_1
	${db_result}=    Query Sybase database    select * from DC_CV_MTAS_MTAS_RAW
    Verify that the table has data for this table    ${db_result}    DC_CV_MTAS_MTAS_RAW
    [Teardown]    Close All Connections
	
	