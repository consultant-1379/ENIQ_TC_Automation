*** Settings ***
Documentation     Validate the alert message thrown when specfic Problem text box is empty and tries to create Alarm
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

Validate the alert message thrown when specfic Problem text box is empty and tries to create Alarm
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC198	
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name1}=      Prepare alarm name     Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     SubNetwork
    Select System area for subnetwork as      Radio
    Select Node type for subnetwork as       NR
    Select Subnetwork as     G2RBS01
    Select Measure type as     COUNTER
    Select measures    aclNdpAndMldPermits.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed   	
	Enter specific problem as Empty        ${EMPTY}
    Enter alarm name     ${alarm_name1}
    Click on scroll down button    5    12
    Click on Apply alarm template button
	Validate the alert message for empty field of Specific Problem		Specific Problem input required     
	[Teardown]    Test teardown steps for pmalarm
    
         
    
  
    

    
    


    


    
    