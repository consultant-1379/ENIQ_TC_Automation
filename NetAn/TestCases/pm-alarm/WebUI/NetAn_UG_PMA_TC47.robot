*** Settings ***
Documentation	  EQEV-105271_Verifying_Editing_An_Alarm_With_A_Pre-Existing_Name
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}


      

*** Test Cases ***
Verify Editing An Alarm With A Pre-Existing Name
	[Tags]    PMA    NetAn_UG_PMA_TC47    EQEV-105271
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Flex1
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
    Select Measure type as     CUSTOM_KPI
    Select measures    PDF_Counter
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Congestion
    Enter specific problem     NA         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button
    Click on Create button
    ${alarm_name1}=      Prepare alarm name         Flex2
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
    Select Measure type as     CUSTOM_KPI
    Select measures    PDF_Counter
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Congestion
    Enter specific problem     NA         ${alarm_name1}
    Enter alarm name     ${alarm_name1}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name1}
    Click on Save button
    select the created alarm and click on edit button    ${alarm_name1}
    validate the page title    Alarm Rules Manager
    Enter alarm name     ${alarm_name}
    Click on Apply changes button    
    verify that the error message is visible
       
    
 

   

    
    


    
    


    