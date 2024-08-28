*** Settings ***

Documentation     Router6k Home Page validation
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${Router6kFile}

*** Test Cases ***

Verifying Home Page    
	open router6k analysis
	Verify the page title    Home
	Verify Network Analytics logo is visible
	Verify Router6k logo is visible
	Click on the button with value    Node Level KPIs
	Verify the page title    Node Level KPIs
	Click on the button    Home
	Verify the page title    Home
	Click on the button with value    Interface Level KPIs
	Verify the page title    Interface Level KPIs
	Click on the button    Home
	Verify the page title    Home
	Check for the error notification is not present