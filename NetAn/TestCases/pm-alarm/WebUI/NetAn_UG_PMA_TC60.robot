*** Settings ***

Documentation     EQEV-103724 - Validate Editing A Report If Eniq Server Is Down
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot

*** Test Cases ***

Validate Editing A Report If Eniq Server Is Down
    [Tags]    PMA_CDB      NetAn_UG_PMA_TC60    EQEV-103724
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         NR_Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as      G2RBS01
    Select Measure type as     KPI
    Select measures    Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Congestion
    Enter specific problem     NA         ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
	Verify alarm title      ${alarm_name}
    Click on Save button
	Verify alarm displayed in UI       ${alarm_name}
	Click on Settings button
    validate the page title    Administration
    disconnect the ENIQ db and go to home page
    Click on Alarm rules manager button
    select the created alarm and click on edit button    ${alarm_name}
    verify that the "Could not change property" error pops up
	[Teardown]    Test teardown steps for pmalarm