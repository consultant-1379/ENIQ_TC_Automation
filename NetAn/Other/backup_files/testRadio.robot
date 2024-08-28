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

Verify the ERBS Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Radio
    Select Node type as    ERBS
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   ERICSSON_KPI     RI 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    ERBS
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the BSC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Radio
    Select Node type as    BSC
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   ERICSSON_KPI     RI 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    BSC
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the RNC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Radio
    Select Node type as    RNC
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   ERICSSON_KPI     RI 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    RNC
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the RBS Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Radio
    Select Node type as    RBS
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   ERICSSON_KPI     RI 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    RBS
    Capture page screenshot
    [Teardown]    Close Browser

Verify the NR Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Radio
    Select Node type as    NR
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   ERICSSON_KPI     RI 
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    NR
    Capture page screenshot
    [Teardown]    Close Browser