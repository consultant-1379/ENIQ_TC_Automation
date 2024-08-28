*** Settings ***
Documentation     Verify Restore the Alarm by selecting multiple items in Deleted Items Page
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

Verify Restore the Alarm by selecting multiple items in Deleted Items Page
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC142	
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
    Enter specific problem     text      ${alarm_name1}
    Enter alarm name     ${alarm_name1}
    Click on scroll down button    5    12
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name1}
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name1}
    Select Alarm       ${alarm_name1}
	Delete the alarm	${alarm_name1}
	click on scroll up button       4        1
	Click on Create button
    ${alarm_name2}=      Prepare alarm name     Alarm_
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
    Enter specific problem     text      ${alarm_name2}
    Enter alarm name     ${alarm_name2}
    Click on scroll down button    5    12
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name2}
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name2}
    Select Alarm       ${alarm_name2}
	Delete the alarm	${alarm_name2}
	Click on Deleted Items
	Verify for multiple selection of deleted alarms Restore button is enabled 		${alarm_name1},${alarm_name2}
	Click on Restore button for alarm		
	Click on Alarm rules manager button
    Verify restored alarms is visible in Alarm Rules		${alarm_name1},${alarm_name2}
	[Teardown]    Test teardown steps for pmalarm
    
         
    
  
    

    
    


    


    
    