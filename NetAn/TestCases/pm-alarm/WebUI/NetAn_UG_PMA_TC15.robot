*** Settings ***
Documentation     Validate the Deactivate button in Alarm rule manager page	
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

Validate the Deactivate button in Alarm rule manager page	
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC15
    open pm alarm analysis
    Click on Alarm rules manager button
    Deactivate any alarm and verify alarm is in Inactive state