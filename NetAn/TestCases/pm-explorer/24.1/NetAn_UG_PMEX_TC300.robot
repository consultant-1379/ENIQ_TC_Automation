*** Settings ***
Documentation     Validate Null Value omission when Ignore Null Values feature is checked
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate Null Value omission when Ignore Null Values feature is checked
    [Tags]       PMEX_CDB         EQEV-125672
	open pm explorer analysis
	Click on Report manager button
    Click on Create button
    Select ENIQ DataSource    NetAn_ODBC
    Select the System area    Radio
    Select Node type    ERBS
    Select Get Data For    Node(s)
    Click on scroll down button     6    20
    Click on Refresh nodes button
    Select Nodes    ERBS1
    Select the Aggregation    No Aggregation
    Select the measure type    PDF_COUNTER
    Select KPIs    pmDrxSwitchPftDistr.DC_E_ERBS_EUTRANCELLFDD_V_RAW
    Select time drop down to      Last 30 Days
    Select Aggregation in select time as     ROP   
	Click on Ignore Null Values check box
    Click on fetch pmdata button
    Switch report page         pm_DC_E_ERBS_EUTRANCELLFDD_V_RAW(No Aggregation Level)__NetAn_ODBC
	Check whether the given value is present in the DCVECTOR_INDEX column       255      0
    Capture page screenshot
