*** Settings ***

Documentation     Verify That An Error is Thrown If The Table From Selected Counter Is Not Present In Selected MultiTable KPI
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

Verify That An Error is Thrown If The Table From Selected Counter Is Not Present In Selected MultiTable KPI
	[Tags]    PMA_CDB          NetAn_UG_PMA_TC26
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name      Alarm_name
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    Select Nodes as    ERBS1
    Select Measure type as     KPI
    Select measures          Average DL PDCP UE Throughput    
    Select Measure type as     COUNTER
    Select measures    pmZtemporary97.DC_E_ERBS_CDMA20001XRTTCELLRELATION_RAW
	Validate Error Message Thrown If The Table From Selected Counter Is Not Present In Selected Multitable KPI
	[Teardown]    Test teardown steps for pmalarm