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
      

*** Test Cases ***

Validate Multi ENIQ Datasource For Unsuccessful Configuration
    [Tags]    PMA_CDB     NetAn_UG_PMA_TC123    
    open pm alarm analysis
	Click on Administration button
    Connect to eniq and validate message           9RepdbFailed_ODBC,9dwhdbFailed_ODBC            Failed to connect with: 9RepdbFailed_ODBC, 9dwhdbFailed_ODBC
    Click on Sync with Eniq
	Navigate to section         ENIQ Connection Status
	Verify repdb connection status        9RepdbFailed_ODBC           Invalid user ID or password
	Verify dwhdb connection status        9RepdbFailed_ODBC           Connected
	Verify repdb connection status        9dwhdbFailed_ODBC           Connected
	Verify dwhdb connection status        9dwhdbFailed_ODBC           Invalid user ID or password 
	Verify the Last Successful Sync With Eniq value for datasource             9RepdbFailed_ODBC            ${EMPTY}
	Verify the Last Successful Sync With Eniq value for datasource             9dwhdbFailed_ODBC            ${EMPTY}         
    
  
    

    
    


    


    
    