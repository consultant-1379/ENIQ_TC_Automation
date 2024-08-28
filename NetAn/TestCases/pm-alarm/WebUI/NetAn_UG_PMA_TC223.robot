*** Settings ***
Documentation     Verify that consumer user is not able to create/edit/delete collections
Library           DatabaseLibrary

Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
      

*** Test Cases ***
	
Verify that consumer user is not able to create/edit/delete collections 
	[Tags]      PMA_CDB      EQEV-126953
    open pm alarm analysis with another username    Consumer    Ericsson01
	Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Verify create edit and delete buttons atre not visible in the page
	Capture page screenshot
