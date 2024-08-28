*** Settings ***
Documentation     Verify when Single Node value is not given and tries to create alarm, alert message wil be thrown
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

Verify when Single Node value is not given and tries to create alarm, alert message wil be thrown
	[Tags]      PMA_CDB      NetAn_UG_PMA_TC193
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name1}=      Prepare alarm name     Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork    Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button in Alarm rules manager
    #No node is selected
    Select Measure type as     COUNTER
    Select measures    aclNdpAndMldPermits.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     text      ${alarm_name1}
    Enter alarm name     ${alarm_name1}
    Click on scroll down button    5    12
    Click on Apply alarm template button
    Verify the alert message for no Single Node value 	Single Node required
	[Teardown]    Test teardown steps for pmalarm
    
         
    
  
    

    
    


    


    
    