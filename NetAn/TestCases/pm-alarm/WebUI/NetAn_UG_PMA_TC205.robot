*** Settings ***

Documentation     Verify That The Edit Page Opens Up For An Inactive Alarm
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

Verify That The Edit Page Opens Up For An Inactive Alarm
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC205
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm_
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
    Enter specific problem     text      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on scroll down button    5    12
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    Select Alarm       ${alarm_name}
	select the created alarm and click on edit button    ${alarm_name}
	verify that the edit alarm page opened up
	[Teardown]    Test teardown steps for pmalarm