*** Settings ***

Documentation     Validate Last Sync With Eniq Connection
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

Validate Last Sync With Eniq Connection
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC118
    open pm alarm analysis
	Click on Administration button
	Connect to DB     localhost       netanserver      Ericsson01     NetAn_ODBC
    navigate to section    ENIQ Connection Status
    Verify dwhdb connection status    NetAn_ODBC    Connected
    Verify repdb connection status	  NetAn_ODBC    Connected
    Verify the Last Successful Sync With Eniq value for datasource    NetAn_ODBC    ${EMPTY}
	[Teardown]    Test teardown steps for pmalarm