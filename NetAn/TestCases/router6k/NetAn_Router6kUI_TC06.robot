*** Settings ***

Documentation     Router6k Verify the data table in Node Level KPIs - Filtered Data page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${Router6kFile}
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Router6k.py 

*** Test Cases ***

Verifying the data table in Node Level KPIs Filtered Data page
	open router6k analysis
	Click on the button with value    Node Level KPIs
	Click on the button with value    Filtered Data >>
	Validate empty visulalization is present
	Check for the error notification is not present
