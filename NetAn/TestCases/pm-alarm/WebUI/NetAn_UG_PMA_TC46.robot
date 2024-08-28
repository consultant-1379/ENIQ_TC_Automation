*** Settings ***
Documentation     Validate That The Report Name Is Editable and edited collection is reflecting in alarm
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

 
*** Test Cases ***
Validate That The Report Name Is Editable
    [Tags]      PMA_CDB      NetAn_UG_PMA_TC46
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Core
    Select Node type for collection manager             CSCF
    Select Access Type
    Click on scroll down button     0      10
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       CSCF01
    Click on Create button
	validate the page title    Node Collection Manager
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Collection
    Select Collection name as      ${collection}
    Select Measure type as     KPI
    Select measures    IMS NIC Receive Requests
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Congestion
    Enter specific problem     NA         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button
    select the created alarm    ${alarm_name}
    Click on Edit button    
    validate the page title    Alarm Rules Manager
    ${alarm_name1}=      Prepare alarm name         EditedAlarm
    Enter alarm name     ${alarm_name1}
    Click on Apply changes button
    Click on Save button
    select the created alarm    ${alarm_name1}
	go to Home page
	Click on Node Collection manager button
	select the created collection      ${collection}
    Click on Edit collection button
	${collection1}=     Enter Collection name         Edit_Collection
    Click on Save button
    Click on collection        ${collection1}
	go to Home page
	Click on Alarm rules manager button
	select the created alarm    ${alarm_name1}
    Click on Edit button    
    validate the page title    Alarm Rules Manager
	Verify edited collection is reflecting in alarm         ${collection1}    
	