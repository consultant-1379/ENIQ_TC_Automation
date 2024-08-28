*** Settings ***
Documentation     Verify WCDMA Settings Page
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



*** Test Cases ***

Verify WCDMA Settings Page
    [Tags]       WCDMA_KGB
	open wcdma overview analysis
	verify that the Network Analytics logo is visible in WCDMA
	Mouse scroller
	Click on the scroll down button    0    15
	click on the button     Settings
	verify the page title    Settings
	click on the scroll down button    1    10
	verify pages displayed on left hand side of settings page
	Select page in settings         Quality of Service           
	verify display duration is displayed in settings page
	verify favorites is displayed with KPIs in settings page
	Select KPI Favourite      0         Data accessibility
	Select KPI Favourite      1         Speech drop rate
	Click on Home button
	Mouse scroller
	Click on the scroll down button    0    10
	click on button    Favorites
	verify the page title    Favorites
	verify favorites page contains KPI information         Data accessibility (Packetint_A)
	verify favorites page contains KPI information         Speech drop rate (Speech_R)
	Click on Home button
	Mouse scroller
	Click on the scroll down button    0    10
	click on button    Play Dashboard
	verify the page title    Quality of Service 
	