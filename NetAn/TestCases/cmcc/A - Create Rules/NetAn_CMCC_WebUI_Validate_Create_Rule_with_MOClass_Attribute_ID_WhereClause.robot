*** Settings ***

Documentation     Verify CMCC Create Rule R3 with MOclass Attribute MO Instance Where Clause
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

Verify CMCC Create Rule R3 with MOclass Attribute MO Instance Where Clause
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on Create Rule button
	create sample Rule with Rulename moclass attribute value    R3    EUtranCellFDD    siPeriodicityBr_siPeriodicitySI9    64    
	Enter MO Instance in Rule Creation    1
	Enter Where Clause value in Rule Creation    MOID like '%ERBS1-2%'
	click on Save Rule button
	verify the page title    CM Rule Manager