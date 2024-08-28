*** Settings ***
Documentation     Functionality of 'Play Dashboard' button
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${WCDMAKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Functionality of 'Play Dashboard' button
    [Tags]       WCDMA_KGB
	open wcdma overview analysis
	Mouse scroller
	click on the scroll down button     0    15
	click on the button    Settings
	verify the page title    Settings
	select the pages for dashboard     Quality of Service,Utilization
	click on the scroll down button    3    20
	decrease the display duration    1    0
	click on the button    Home
	verify the page title    Start
	Mouse scroller
	click on the scroll down button    0    15
	click on button    Play Dashboard
	Verify the page titles in Play Dashboard
	Capture page screenshot
	