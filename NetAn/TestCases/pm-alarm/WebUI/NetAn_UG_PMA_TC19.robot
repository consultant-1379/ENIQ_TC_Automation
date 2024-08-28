*** Settings ***
Documentation     Validate the Import functionality in Alarm Rule Manager page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Library           CSVLib
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
      

*** Test Cases ***

Validate the Import functionality in Alarm Rule Manager page
    [Tags]      PMA     NetAn_UG_PMA_TC19
    ${alarm_rule}=      Change alarm rule name in alarm definition file
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Import button
    Select alarm rule file      ${alarm_rule}
    Assign nodes/collections to alarm rule
    Click on Import Alarm rules
    Validate alarm rule imported is displayed in import result