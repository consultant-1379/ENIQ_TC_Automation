*** Settings ***

Documentation     Verify CMCC Create Rule R4 with MOclass Attribute TableName    
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

Verify CMCC Create Rule R4 with MOclass Attribute TableName
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on Create Rule button
	create sample Rule with Rulename moclass attribute value    R4    EUtranCellFDD    pciDetectingCell_mncLength    2
	Enter VectorIndex value in Rule Creation    3    	
	Enter TableName value in Rule Creation    DC_E_BULK_CM_EUTRANCELLFDD_V    
	click on Save Rule button
	verify the page title    CM Rule Manager
	
	