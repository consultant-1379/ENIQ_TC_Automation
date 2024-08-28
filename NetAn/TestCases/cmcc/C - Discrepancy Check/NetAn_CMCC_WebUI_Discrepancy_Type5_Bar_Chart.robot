*** Settings ***

Documentation     Verify Discrepancies Worst Node Bar Chart has Data for Caps And Small MO Class    
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

Verify Discrepancies Worst Node Bar Chart has Data for Caps And Small MO Class
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	Filter MO Class for case sensitive    EUtranFreqRelation  
	${date}=    Select Date from drop down 
	select the Rule Name in CM Rule Manager    R5
	click on Execute Rules button
	verify the page title    Discrepancies
	select a rule in Discrepancies page
	select bar charts in discrepancis page
	verify that the marked value is not 0