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

Suite Setup         Suite setup steps	

*** Test Cases ***

Verify Functionality of "Favorites" Page
	open ran performance wcdma overview analysis
	Click on the scroll down button    0    15
	click on the button     Settings
	verify the page title    Settings
	Select 5 favorite KPIs under Favorites
	click on the button      Home
	Click on the scroll down button    0    15
	click on button    Favorites
	verify the page title    Favorites
	verify five selected KPIs of Settings page is visible in favorites page
	click button 	Favorites: Details
	verify detailed data in charts of Details Page
	click on the button      Home
	Click on the scroll down button    0    15
	click on the button     Settings
	verify the page title    Settings
	Select another 5 favorite KPIs under Favorites
	click on the button      Home
	Click on the scroll down button    0    15
	click on button    Favorites
	verify the page title    Favorites
	verify selected KPIs is visible in Settings page 
	click button 	Favorites: Details
	verify detailed data in charts of Details Page
	[Teardown]    Test teardown
	
*** keywords *** 
    
Test teardown steps
    Capture page screenshot
    Close Browser

Suite setup steps
    
    Set Screenshot Directory   ./Screenshots

Suite teardown steps
    Capture page screenshot		
