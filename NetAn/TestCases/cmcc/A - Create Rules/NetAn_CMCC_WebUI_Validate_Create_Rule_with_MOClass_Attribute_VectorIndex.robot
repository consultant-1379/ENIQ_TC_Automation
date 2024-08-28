*** Settings ***

Documentation     Verify CMCC Create Rule R2 with MOclass Attribute VectorIndex
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

Verify CMCC Create Rule R2 with MOclass Attribute VectorIndex
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on Create Rule button
	create sample Rule with Rulename moclass attribute value    R2    EUtranCellFDD    siPeriodicityBr_siPeriodicitySI9    64    
	Enter VectorIndex value in Rule Creation    5    
	click on Save Rule button
	verify the page title    CM Rule Manager