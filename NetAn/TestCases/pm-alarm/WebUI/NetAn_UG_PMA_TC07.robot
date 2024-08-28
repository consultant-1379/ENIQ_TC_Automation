*** Settings ***
Documentation     Validate Delete functionality in Step1: connected data sources in PMA Admin page	
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

Validate Delete functionality in Step1: connected data sources in PMA Admin page	
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC07
    open pm alarm analysis
    Connect to the DB    NetAn_4140
    Select datasource from Eniq connection status and delete       NetAn_4140
    Verify datasource is not available     NetAn_4140