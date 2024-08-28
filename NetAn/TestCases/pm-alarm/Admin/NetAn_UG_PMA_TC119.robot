*** Settings ***

Documentation     Validate Multi ENIQ Datasource Connection For DWHDB And REPDB
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

Validate Multi ENIQ Datasource Connection For DWHDB And REPDB
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC119
    open pm alarm analysis
    Click on Administration button
	Connect to DB     localhost       netanserver      Ericsson01       NetAn_ODBC,4140_ODBC
	navigate to section    ENIQ Connection Status
    Verify dwhdb connection status    NetAn_ODBC    Connected
    Verify repdb connection status	  NetAn_ODBC    Connected
	Verify dwhdb connection status    4140_ODBC    Connected
    Verify repdb connection status	  4140_ODBC    Connected
    [Teardown]    Test teardown steps for pmalarm 