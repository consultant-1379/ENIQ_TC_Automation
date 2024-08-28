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

Verify CMCC Discrepancies button
	[Tags]    CMCC_CDB
	open cmcc analysis
	click on Rule Manager button
	verify the page title    CM Rule Manager
	Click on the scroll down button    0    1
	Click on Discrepancies button
	verify navigation should not happen    Discrepancies
	Verfiy Date panels
	select multiple rules in cm rule page
	click on Execute Rules button
	verify the page title    Discrepancies
	click on Rule Manager button
	verify the page title    CM Rule Manager
	click on button    Discrepancies
	verify the page title    Discrepancies