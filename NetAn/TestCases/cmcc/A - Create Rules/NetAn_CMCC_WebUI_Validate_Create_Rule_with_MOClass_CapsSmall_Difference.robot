*** Settings ***

Documentation     Verify CMCC Create Rule R5 with CapsSmall Difference
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

Verify CMCC Create Rule R5 with MOclass CapsSmall Difference 
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on Create Rule button
	create sample Rule with Rulename moclass attribute value    R5    EUtranFreqRelation    a5Thr1RsrpFreqOffset    -26
	Enter TableName value in Rule Creation    DC_E_BULK_CM_EUTRAFREQRELATION    
	click on Save Rule button
	verify the page title    CM Rule Manager
	
	