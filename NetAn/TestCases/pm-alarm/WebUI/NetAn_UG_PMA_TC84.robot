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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
      

*** Test Cases ***

Verify That If A Connection Is Deleted It Is Also Removed From All Tables
    [Tags]      PMA_KGB     NetAn_UG_PMA_TC84
    open pm alarm analysis
    Click on Administration button
	Connect to DB     localhost       netanserver      Ericsson01       NetAn_ODBC,4140_ODBC
	navigate to section    ENIQ Connection Status
    Verify dwhdb connection status    NetAn_ODBC    Connected
    Verify repdb connection status	  NetAn_ODBC    Connected
	Verify dwhdb connection status    4140_ODBC    Connected
    Verify repdb connection status	  4140_ODBC    Connected
	Select datasource from Eniq connection status and delete         4140_ODBC
	Verify datasource is not available         4140_ODBC
	go to Home page
	Click on Alarm rules manager button
    Click on Create button
    verify that the deleted eniq is not visible in Alarm rules manager page    4140_ODBC
	go to Home page
	Click on Node Collection manager button
    Click on Create collection button
	verify that the deleted eniq is not visible in Node collection manager page        4140_ODBC
    verify that the deleted eniq is not visible in tblEniqDS table         4140_ODBC 
       
    
 
    

    
    

    
    


    
    