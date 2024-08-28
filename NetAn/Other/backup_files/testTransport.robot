*** Settings ***
Documentation     Testing Core Nodetypes
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/WebUI.robot
Suite setup        Set Screenshot Directory    ./Screenshots


*** Variables ***
${base_url}=       https://localhost/
${pmex_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Explorer/PM-Explorer/Analyses/PM%20Explorer&waid=Tza-om0C4Emhp9dxoJ0wu-091024061e335T&wavid=0
${browser_name}=   chrome

*** Test Cases ***

Verify the Mini-Link Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Transport
    Select Node type as     Mini-Link
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title     Mini-Link
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the FrontHaul Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Transport
    Select Node type as    FrontHaul
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    FrontHaul
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the Router6k Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Transport
    Select Node type as    Router6k
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    Router6k
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the Juniper Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Transport
    Select Node type as    Juniper
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    Juniper
    Capture page screenshot
    [Teardown]    Close Browser

