*** Settings ***
Documentation     Validate the : "the change in order of selecting KPIs or Counters in measure will not affect the output." list in Alarm Rule Manager page 
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

Validate the : "the change in order of selecting KPIs or Counters in measure will not affect the output." list in Alarm Rule Manager page 
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC14
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Multi_Table_Counter_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area and verify none value is not present      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    Select Nodes as    ERBS1
    Select MOClass as empty and verify error message
    Select Measure type as     COUNTER,KPI
    Select measures          pmCellDowntimeAuto.DC_E_ERBS_EUTRANCELLFDD_RAW,Average DL PDCP UE Throughput,pmCellDowntimeMan.DC_E_ERBS_EUTRANCELLFDD_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     NA      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Verify columns displayed    DATE_ID