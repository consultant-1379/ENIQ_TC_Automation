*** Settings ***
Documentation     Dataintegrity testcase

Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           SwingLibrary
Resource          ./Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ./Resources/Keywords/VoLTEWebUI.robot
Library           ./Resources/Libraries/DynamicTestcases.py
Test Setup        Open Connection And Log In     ${host}     ${username}    ${password}     ${PORT}
Test Teardown     Close All Connections
Suite setup       Set Screenshot Directory    ./Screenshots

*** Variables ***

${base_url}=        https://localhost/
${volte_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/LTE/VoLTE/Ericsson-VoLTE-Report/Analyses/Volte_Guided_Analysis&waid=dzVcvNCdUkmOmgpPZOg1x-300543061eBwfK&wavid=0
${browser_name}=    chrome
${IMAGE_DIR}        ${EXECDIR}/Other/sikuli-images
${host}             localhost
${username}         Administrator
${password}         teamci@2017
${PORT}             2640

***Test Cases***

Test Case: Open VoLTE_Guided_Analysis - Ericsson Network Analysis
    open volte analysis
	click on Home button if not in volte home page
	Click on scroll down button on the current page    20    0   
	click on VoLTE Reset button
    click on button title    Services Comparison
    validate page title as    Service Comparison
    Verifying the headings of charts
    Making selection on graph    E-RAB Retainability Abnormal Releases
    Checking marked value
    click on button title    Home
    click on VoLTE Reset button
    click on button title    Services Comparison
    validate page title as    Service Comparison
    Marked value should be 0
    Capture page screenshot
    [Teardown]    Close Browser
	
Test Case: Open VoLTE_Guided_Analysis - Ericsson Network Analysis
    open volte analysis
	click on Home button if not in VoLTE home page
	Click on scroll down button on the current page    20    0   
	click on VoLTE Reset button
    click on button title    VoLTE Monitor
    validate page title as    VoLTE Monitor
    Select KPI
    click on button value    Node Troubleshooting >>
    validate page title as    Node Troubleshooting
    Make selections in KPI    MTAS
    click on button value    Daily Breakdown >>
    validate page title as    Daily Breakdown
    select days to compare    MTAS
    click on button value    Filtered Data >>
    validate page title as    Filtered Data
    first 10 columns should have data
    Capture page screenshot
    [Teardown]    Close Browser

Test Case: Functionality of Settings Page
    open volte analysis
	click on s10 Home button if not in VoLTE home page
	Click on scroll down button on the current page    20    0   
	click on VoLTE Reset button
    click on button title    Settings
    validate the page title as    Settings
    ${sbg}=    Selecting the first SBG and MOID
    click on button value    Save
    Click on scroll down button on the current page    12    2
    Selected MOID should come under relevant NetId    ${sbg}
    click on button value    Clear All
    Relevant section should be empty
    Capture page screenshot
    [Teardown]    Close Browser
    
    
    
    
    