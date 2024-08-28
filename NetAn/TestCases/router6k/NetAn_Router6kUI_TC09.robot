*** Settings ***

Documentation     Router6k Verify the chart's titles in Interface Details page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${Router6kFile}

*** Test Cases ***

Verifying the chart titles in Interface Level KPIs page
	open router6k analysis
	Click on the button with value    Interface Level KPIs
	Verify the page title    Interface Level KPIs

	Click on the button with value    Interface Details >>
	Verify the page title    Interface Details
	${chart_title}=    Get Chart Title Count
	IF  ${chart_title}!=2
	    Fail    'Chart titles missing in Node Level KPIs page'
	END
	Check for the error notification is not present
	