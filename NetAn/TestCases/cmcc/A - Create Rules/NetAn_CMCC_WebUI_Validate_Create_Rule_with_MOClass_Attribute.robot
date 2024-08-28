*** Settings ***

Documentation     Verify CMCC Create Rule R1 with MOclass Attribute    
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

Verify CMCC Create Rule R1 with MOclass Attribute
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on Create Rule button
	create sample Rule with Rulename moclass attribute value    R1    AnrFunction    removeNrelTime    2    
	click on Save Rule button
	verify the page title    CM Rule Manager