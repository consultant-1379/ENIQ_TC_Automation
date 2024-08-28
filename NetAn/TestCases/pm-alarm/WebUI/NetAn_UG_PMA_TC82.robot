*** Settings ***
Documentation     EQEV-110751 Validate The Export Button In Alarm Rules Manager Page
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

Validate The Export Button In Alarm Rules Manager Page
    [Tags]    PMA_CDB     NetAn_UG_PMA_TC82    EQEV-110751
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Alarm
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
    Select Measure type as     KPI
    Select measures    Average DL MAC Cell Throughput Captured in gNodeB- Fixed Time Normalized
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Enter the specific problem
    Enter alarm name     ${alarm_name}
    click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button
    Activate the alarm    ${alarm_name}
    Select Alarm    ${alarm_name}
    Click on Export button