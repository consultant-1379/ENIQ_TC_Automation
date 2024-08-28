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
Suite Setup    	  Connect to server as a dcuser
Suite Teardown     Test Teardown steps    

*** Test Cases ***

Data loading for DC_E_VOWIFI_KPI_RAW table For KPI_ID = 5
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
    remove file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII
    create file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII    PARAMETER;VALUE
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII    \n
    append to file    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\vowifiConfig.ASCII    NODEIDOFFSET;1000000	
	place the file in the directory    vowifiConfig.ASCII    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files    /eniq/data/pmdata/eniq_oss_1/vowifiConfig/
	verify the file placed in proper directory     vowifiConfig.ASCII    vowifiConfig
	open the adminui page
	click on button     ETLC Set Scheduling
	verify the page title    ETLC Set Scheduling
	select the type    Interface
	select the package    INTF_DIM_E_VOWIFI-eniq_oss_1
	click on button     ETLC Set Scheduling
	verify the page title    ETLC Set Scheduling
	select the type    Interface
	select the package    INTF_DIM_E_VOWIFI_CONFIG-eniq_oss_1
	sleep    30
	${db_result_1}=    Query Sybase database    select * from DIM_E_VOWIFI_NODE
    Verify that the table has data    ${db_result_1}    DIM_E_VOWIFI_NODE
    sleep    5
    ${db_result_2}=    Query Sybase database    select * from DIM_E_VOWIFI_KPI
    ${status}=    Verify that the table has data    ${db_result_2}    DIM_E_VOWIFI_KPI
    Verify that the table is not empty    ${status}    
    click on button     ETLC Set Scheduling
	verify the page title    ETLC Set Scheduling
	select the type    Interface
	select the package    INTF_DC_E_VOWIFI-eniq_oss_1
	${db_result}=    query the DC_E_VOWIFI_KPI_RAW table    5    EPG S2b PDN Connection Creation Success
    [Teardown]    Test Teardown steps
