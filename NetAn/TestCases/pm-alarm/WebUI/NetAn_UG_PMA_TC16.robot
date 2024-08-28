*** Settings ***
Documentation     Testing Core Nodetypes
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           SikuliLibrary
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
      

*** Test Cases ***

Validate Delete Button in Step3: Setup ENM Connection in PMA Admin page	
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC16
    open pm alarm analysis
    Set up ENM connection
    Delete the connected ENM
    Verify ENM connection is not available