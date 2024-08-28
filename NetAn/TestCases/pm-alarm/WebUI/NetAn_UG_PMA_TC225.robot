*** Settings ***

Documentation     MR-EQEV-110783 Validate the Apply PDF setting button when inputfield is empty
Library           DatabaseLibrary
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***
Validate the Apply PDF setting button when inputfield is empty
    [Tags]        EQEV-110783    NetAn_UG_PMA_TC225       PMA_CDB
    open pm alarm analysis
    Click on Alarm rules manager button
    click on scroll down button    0    20
    Click on Create button
    ${alarm_name}=      Prepare alarm name         PDF
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as     G2RBS01
	Select measures         delayRtP95.DC_E_TCU_TWAMP_TEST_SESSION_V_RAW
    Select PDF value from dropdown    Custom
    Click on apply PDF setting button
	Validate PDF Error Message 
	Enter Custom value    test
	Click on apply PDF setting button
    Validate PDF Error Message 


	