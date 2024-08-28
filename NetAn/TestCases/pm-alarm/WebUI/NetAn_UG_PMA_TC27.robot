*** Settings ***

Documentation     Verify That An Error is Thrown If The Table From Selected RI Is Not Present In Selected KPI
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot        

*** Test Cases ***

Verify That An Error is Thrown If The Table From Selected RI Is Not Present In Selected KPI
    [Tags]    PMA_CDB    NetAn_UG_PMA_TC27
	open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name      Alarm_name
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as    G2RBS01
    Select Measure type as     KPI
    Select measures          ESS RLC Delay    
    Select Measure type as    RI
    Select measures    UL Volume per Cell   
    Validate Error Message Thrown If The Table From Selected RI Is Not Present In Selected KPI
	[Teardown]    Test teardown steps for pmalarm