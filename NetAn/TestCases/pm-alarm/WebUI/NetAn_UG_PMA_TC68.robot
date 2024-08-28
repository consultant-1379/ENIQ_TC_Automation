*** Settings ***
Documentation     Validate The Alarm Information Column In Alarm Rules Manager Page
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

Validate The Alarm Information Column In Alarm Rules Manager Page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC68    MR-EQEV-110751
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    validate that the dropdown Alarm Severity is working as expected
    validate that the dropdown Aggregation is working as expected
    validate that the dropdown Probable Cause is working as expected