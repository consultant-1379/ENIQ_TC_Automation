*** Settings ***

Documentation     Verify Whether Sync With Eniq Is Running Only For Connected Servers
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

Verify Whether Sync With Eniq Is Running Only For Connected Servers
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC117
    open pm alarm analysis
	Connect to DB and sync with eniq          NetAn_ODBC,4140_ODBC,Failed_ODBC 
	navigate to section    ENIQ Connection Status
    Verify dwhdb connection status    NetAn_ODBC    Connected
    Verify repdb connection status	  NetAn_ODBC    Connected
	Verify the Last Successful Sync With Eniq value for datasource	  NetAn_ODBC    Europe
	Verify dwhdb connection status    4140_ODBC    Connected
    Verify repdb connection status	  4140_ODBC    Connected
	Verify the Last Successful Sync With Eniq value for datasource	  4140_ODBC    Europe
	Verify the Last Successful Sync With Eniq value for datasource	  Failed_ODBC    ${EMPTY}
    [Teardown]    Test teardown steps for pmalarm