*** Settings ***
Documentation     Validate the Measure Type: "if more than one counter is selected from different tables with a Mutitable KPI having those tables in TableName column " combination list in Alarm Rule Manager page
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot        


      

*** Test Cases ***

Validate the Measure Type: "if more than one counter is selected from different tables with a Mutitable KPI having those tables in TableName column " combination list in Alarm Rule Manager page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC20  
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    select system area      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    Select Nodes as    ERBS1
    Select Measure type as     COUNTER,KPI
    Select measures          Cell Handover Success Rate,pmZtemporary97.DC_E_ERBS_CDMA20001XRTTCELLRELATION_RAW,pmHoPrepAtt.DC_E_ERBS_GERANCELLRELATION_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     NA      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Verify columns displayed    DC_TIMEZONE
    ${alarm_criteria}=     Verify alarm criteria
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active