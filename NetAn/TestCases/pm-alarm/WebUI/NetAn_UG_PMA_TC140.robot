*** Settings ***
Documentation     Verify multiple selection for Restore of Collection & Restore of Alarm
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

Verify multiple selection for Restore of Collection & Restore of Alarm
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC140	
    open pm alarm analysis
    Click on Node Collection manager button
    Click on Create collection button
    ${collection1}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
	Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01,G2RBS04
    Click on Create button
	Click on collection        ${collection1}	
	Delete the collection
	Click on Create collection button
    ${collection2}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
	Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01,G2RBS04
    Click on Create button
    Click on collection        ${collection2}	
	Delete the collection
	Click on Deleted Items
	Verify for multiple selection of deleted collection Restore button is enabled 		${collection1},${collection2}
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
	[Teardown]    Test teardown steps for pmalarm
    
         
    
  
    

    
    


    


    
    