*** Settings ***

Documentation     Router6k Verify the navgigation buttons in Node Level KPIs page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${Router6kFile}

*** Test Cases ***

Verifying the navgigation buttons in Node Level KPIs page
	open router6k analysis
	Click on the button with value    Interface Level KPIs
	Verify the page title    Interface Level KPIs

	Click on the button with value    Interface Details >>
	Verify the page title    Interface Details
	
	Click on the button with value    Filtered Data >>
	Verify the page title    Interface Level KPIs - Filtered Data
	
	Click on the button with value    << Interface Details
	Verify the page title    Interface Details
	
	Click on the button with value    << Interface Level KPIs
	Verify the page title    Interface Level KPIs

	Click on the button with value    Filtered Data >>
	Verify the page title    Interface Level KPIs - Filtered Data

	Click on the button with value    << Interface Level KPIs
	Verify the page title    Interface Level KPIs

	Click on the button with value    Interface Details >>
	Verify the page title    Interface Details
	
	Click on the button with value    Filtered Data >>
	Verify the page title    Interface Level KPIs - Filtered Data

    Click on the button with value    << Interface Level KPIs
	Verify the page title    Interface Level KPIs
	Check for the error notification is not present