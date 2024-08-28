*** Settings ***

Documentation     Verify CMCC Delete button for Rule
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

Verify CMCC Excute Rules And Edit Button
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	Click on the scroll down button    4    1
	Click on excute rules button
	verify navigation should not happen    Discrepancies
	Verfiy Date panels
	Verify selected rule is valid in cm rule manager
	click on Execute Rule button
	verify the page title    Discrepancies
	click on Rule Manager button
	verify the page title    CM Rule Manager
	select multiple rules in cm rule page
	Verify if edit button is disabled