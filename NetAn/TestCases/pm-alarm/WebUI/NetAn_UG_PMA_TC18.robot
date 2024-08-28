*** Settings ***
Documentation     Validate the Export button in Alarm Rule Manager page
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

Validate the Export button in Alarm Rule Manager page	
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC18
    open pm alarm analysis
    Click on Alarm rules manager button
    Export any alarm and validate successful export message