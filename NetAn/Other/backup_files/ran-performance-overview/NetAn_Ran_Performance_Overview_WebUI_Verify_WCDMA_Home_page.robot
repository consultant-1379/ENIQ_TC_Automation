*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/RanPerformanceOverviewWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps

*** Test Cases ***

Verify WCDMA Home Page
	open ran performance wcdma overview analysis
	verify that the Network Analytics logo is visible in RPO-WCDMA
	verify that the Ran Performance Overview WCDMA logo is visible
    Click on the scroll down button    0    15
	verify that the reset button is visible
	click on the button    Reset All Filters and Markings
	verify that the button is visible    Play Dashboard
	verify that the button is visible    Favorites
	verify that the button is visible    KPI Exploration
	click on button    Play Dashboard
	verify the page title    Mobility and Accessibility
	Click on Home button
	Click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings	
	click on button    Favorites
	verify the page title    Favorites
	click on the button      Home
	Click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings	
	click on button     KPI Exploration
	verify the page title    KPI Exploration
	click on the button    Home
	Click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings
	click on the scroll down button    0    15
	click on the button     Settings
	verify the page title    Settings
	click on the button    Home
	Click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings
	[Teardown]      Test teardown steps
	
*** keywords ***    
    
Test teardown steps
    Capture page screenshot
    Close Browser

Suite setup steps
    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot	
 	