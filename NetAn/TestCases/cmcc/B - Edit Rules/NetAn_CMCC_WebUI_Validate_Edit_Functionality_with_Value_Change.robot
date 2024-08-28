*** Settings ***

Documentation     Verify CMCC Edit Button for R1 Value
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${CMCCKeywordsFile}

*** Test Cases ***

Verify CMCC Edit Button for R1 Value
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	select the Rule Name in CM Rule Manager    R1
	click on Edit button
	Edit Text in Existing Value    Value    1    
	click on Save Rule button
	verify the page title    CM Rule Manager