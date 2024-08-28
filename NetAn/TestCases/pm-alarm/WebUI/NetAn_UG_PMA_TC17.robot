*** Settings ***

Documentation     Validate the Edit Button in Alarm Rule Manager page
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

Validate the Edit Button in Alarm Rule Manager page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC17
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name    Edit
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    select system area      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as    G2RBS01
    Select Measure type as     COUNTER
    Select measures    aclNdpAndMldPermits.DC_E_TCU_ACLIPV6_RAW,aclTotalDiscards.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     NA         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    sleep    60
    Verify alarm title      ${alarm_name}
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    Select Alarm       ${alarm_name}
    Click on Edit button    
    Click on scroll down button     2      50
    Enter specific problem         Changed         ${alarm_name}  
    Click on Apply changes button 
    Click on Save button 
    Verify specific problem is changed       ${alarm_name}       Changed     