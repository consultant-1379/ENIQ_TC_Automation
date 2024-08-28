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

Data loading for DC_E_VOWIFI_KPI_RAW, DIM_E_VOWIFI_KPI, DIM_E_VOWIFI_NODE table
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
	${db_result_3}=    Query Sybase database    select * from DC_E_VOWIFI_KPI_RAW
    Verify that the table has data    ${db_result_3}    DC_E_VOWIFI_KPI_RAW
	[Teardown]    Test Teardown steps
