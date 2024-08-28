*** Settings ***
Documentation     Validate functionality of Cancel button in alarm rules manager page
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
   
Validate functionality of Cancel button in alarm rules manager page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC09
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Cancel
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    select system area      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as    G2RBS01
    Select Measure type as     COUNTER
    Select measures    aclNdpAndMldPermits.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     text      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}    
    Click on Cancel button 
    Verify alarm is not displayed in UI       ${alarm_name}