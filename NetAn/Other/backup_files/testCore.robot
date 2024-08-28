*** Settings ***
Documentation     Testing Core Nodetypes
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/WebUI.robot
Suite setup      Set Screenshot Directory   ./Screenshots

*** Variables ***
${base_url}=       https://localhost/
${pmex_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Explorer/PM-Explorer/Analyses/PM%20Explorer&waid=Tza-om0C4Emhp9dxoJ0wu-091024061e335T&wavid=0
${browser_name}=   chrome

*** Test Cases ***

Verify the CCDM Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CCDM
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CCDM
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the CCES Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CCES
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CCES
    Capture page screenshot
    [Teardown]    Close Browser


Verify the CCPC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CCPC
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CCPC
    Capture page screenshot
    [Teardown]    Close Browser

Verify the CCRC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CCRC
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CCRC
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the CCSM Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CCSM
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CCSM
    Capture page screenshot
    [Teardown]    Close Browser
    

    

Verify the CSCF Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CSCF
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CSCF
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the DSC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CSCF
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CSCF
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the EPG Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CSCF
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CSCF
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the M-MGW Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    CSCF
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    CSCF
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the MTAS Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    MTAS
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    MTAS
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the PCG Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    PCG
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    PCG
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the PCG Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    PCG
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    PCG
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the SAPC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    SAPC
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    SAPC
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the SBG Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    SBG
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    SBG
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the SC Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    SC
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    SC
    Capture page screenshot
    [Teardown]    Close Browser
    
Verify the SGSN-MME Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    SGSN-MME
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    SC
    Capture page screenshot
    [Teardown]    Close Browser
    

Verify the SGSN-MME Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    SGSN-MME
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    SGSN-MME
    Capture page screenshot
    [Teardown]    Close Browser
    
 Verify the vMRS Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    vMRS
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    vMRS
    Capture page screenshot
    [Teardown]    Close Browser
    
  Verify the Core-IPWorks Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    IPWorks
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    IPWorks
    Capture page screenshot
    [Teardown]    Close Browser  
    
 Verify the Core-IPWorks Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    vAFG
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    vAFG
    Capture page screenshot
    [Teardown]    Close Browser  
    
 Verify the vHLR-FE Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    vHLR-FE
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    vHLR-FE
    Capture page screenshot
    [Teardown]    Close Browser  
    
 Verify the vHSS-FE Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    vHSS-FE
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    vHSS-FE
    Capture page screenshot
    [Teardown]    Close Browser
    
  Verify the WMG Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    WMG
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    WMG
    Capture page screenshot
    [Teardown]    Close Browser
    
  Verify the WMG Counters
    open pm explorer analysis
    Click on Create button
    Select System area as    Core
    Select Node type as    WMG
    Select Aggregation as    No Aggregation
    Click on fetch nodes button 
    Click on Select measure
    Select the measure type   COUNTER     PDF_COUNTER
    Click on Select time
    Select Aggregation in select time as     ROP
    Select KPIs
    Click on Add button
    Click on fetch pmdata button 
    Validate the page title    WMG
    Capture page screenshot
    [Teardown]    Close Browser
    