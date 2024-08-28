*** Settings ***

Documentation     Validate Check Rule Button in CM Rule Manager Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${CMCCKeywordsFile}

*** Test Cases ***

Validate Check Rule Button in CM Rule Manager Page
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on Create Rule button
	${currDate}=    Get current date
	create sample Rule with Rulename moclass attribute value    ${currDate}    Beam    beamId    FALSE    
	click on Save Rule button
	verify the page title    CM Rule Manager
	select the Rule Name in CM Rule Manager    ${currDate}
	Verify Check Rules Button
	