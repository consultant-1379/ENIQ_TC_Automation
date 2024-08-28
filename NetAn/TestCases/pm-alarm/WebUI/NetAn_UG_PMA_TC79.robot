*** Settings ***
Documentation     Validate The Activate Button In Alarm Rules Manager Page
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

Validate The Activate Button In Alarm Rules Manager Page
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC79     MR-EQEV-110751
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Validate if Measure listbox is updated only after System Area and Node Type value is entered
    Validate if after changing System area value Node type is empty for Single Node    Radio    Core
    Click on fetch nodes button
    Select Nodes as    G2RBS01
    Select Measure type as     KPI
    Select measures    Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized
    Validate measures are getting cleared when clicking on clear measure button    Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized
    Select measures    Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Enter the specific problem
    Click on Apply alarm template button
    ${alarm_name}=      Prepare alarm name         Alarm
    Enter alarm name     ${alarm_name}
    Validate if exception message is thrown when creating alarm without Alarm Name
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button
    Verify alarm displayed in UI       ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Inactive
    Activate the alarm     ${alarm_name}
    Verify alarm state in DB      ${alarm_name}     Active
    select an activated alarm and click on delete
    Verify OK button in deleted alarm message dialog box
    select an activated alarm and click on delete
    Verify cancle button in deleted alarm message dialog box
    select an activated alarm and click on delete
    Verify the deleted alarm message