*** Settings ***

Documentation     Verifying That The DB And UI Discrepancy Values Match For Vector Attribute   
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${CMCCKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Verifying That The DB And UI Discrepancy Values Match For Vector Attribute
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	Filter MO Class    EUtranCellFDD    
	${date}=    Select Date from drop down 
	select the Rule Name in CM Rule Manager    R2
	click on Execute Rules button
	verify the page title    Discrepancies
	select a rule in Discrepancies page
	${uiValue}=    read the value Percentage Discrepancies
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/cmcc/cmcc.json     Type2
	${sql_query}=    replace date values in the query    ${sql_query}    ${date}
	${dbValue}=    Query Sybase database    ${sql_query}
	${dbValue1}=    convert to string    ${dbValue}
	should contain    ${dbValue1}    ${uiValue}