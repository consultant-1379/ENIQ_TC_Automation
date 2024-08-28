*** Settings ***
Force Tags  suite
Documentation     PMA Testcase
Documentation     DB connection
Test Setup       Open Connection And Log In     ${host}     ${username}    ${password}    ${PORT}
Test Teardown    Close All Connections
Suite setup      Set Screenshot Directory   ./Screenshots
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library          SSHLibrary
Library          DateTime
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ./Resources/Keywords/Variables.robot
Resource          ./Resources/Keywords/App_Coverage_Map_WebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py
																								   
										

*** Variables ***


*** Test Cases ***
# NetAnServer18.2_18.2.8_EU02_0015 
#Verify Operation of Icons and Navigation Buttons on App Coverage Map Analysis
    open app coverage map analysis
    verify app coverage map analysis page opened
    click on cell performance button
    verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    Select from Uplink/Downlink dropdown      Downlink
    Click on Cell Site Location button
    verify Cell Site Location Page opens on App Coverage Map Analysis
    click on cell performance Ranking button
    verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    Click on Cell Site Location button
    verify Cell Site Location Page opens on App Coverage Map Analysis
    click on Home button
    verify Home Page opens on App Coverage Map Analysis
    click on cell performance button
    verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    click on Home button
    verify Home Page opens on App Coverage Map Analysis
    click on cell performance button
    verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    Select from Uplink/Downlink dropdown      Uplink
    Click on Cell Site Location button
    verify Cell Site Location Page opens on App Coverage Map Analysis
    click on cell performance Ranking button
    verify Cell Performance Ranking Page opens on App Coverage Map Analysis
    Click on Cell Site Location button
    verify Cell Site Location Page opens on App Coverage Map Analysis
    click on Home button
    verify Home Page opens on App Coverage Map Analysis
    click on Network Overview button
    verify Network Overview opens on App Coverage Map Analysis
    click on Home button
    verify Home Page opens on App Coverage Map Analysis
 
# NetAnServer18.2_18.2.8_EU02_0016   
Verify Page Headings and Labels of Charts on App Coverage Map Analysis
    open app coverage map analysis
    verify app coverage map analysis page opened
    verify license number displayed     CNA 403 3455
    click on cell performance button
    verify Cell Performance Ranking Page opens on App Coverage Map Analysis 
    Verify first chart title displayed as     Worst Performing Cells (Ranked by Avg Failed User Sessions) 
	

*** Keywords ***  
    
    
    

