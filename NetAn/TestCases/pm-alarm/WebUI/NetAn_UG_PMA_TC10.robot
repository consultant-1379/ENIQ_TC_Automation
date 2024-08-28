*** Settings ***
Documentation     Validate multi ENIQ configuration in settings page
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

Validate multi ENIQ configuration in settings page	
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC10
    open pm alarm analysis
    Connect to the DB      NetAn_ODBC,NetAn_4140
    Validate ENIQ connections are displayed           NetAn_ODBC,NetAn_4140