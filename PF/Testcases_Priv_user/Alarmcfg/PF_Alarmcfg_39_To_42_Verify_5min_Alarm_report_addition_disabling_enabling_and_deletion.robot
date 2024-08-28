*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Test Cases ***
Verify 5min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${cdb_almcfg_sys}    ${cdb_almcfg_user}    ${cdb_almcfg_pass}    ${cdb_almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    5min
    Verify Interface page is displayed    5min
    Verify target reports are not added    ${5min_basetable}    ${5min_alm_template}    5min
    Click Add report button
    Select alarm template from available reports    ${5min_alm_template}
    Select basetable from dropdown list    ${5min_basetable}
    Click Add alarm report button
    ${alm_report_status}=    Verify alarm report addition    ${5min_basetable}    ${5min_alm_template} 
    Skip If    ${alm_report_status}==False 

Verify 5min Interface Alarm report disabled    
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    5min    ${5min_basetable}    ${5min_alm_template}
    Verify message is displayed    successfully disabled

Verify 5min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    5min    ${5min_basetable}    ${5min_alm_template}
    Verify message is displayed    successfully enabled

Verify 5min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    5min    ${5min_basetable}    ${5min_alm_template}
    Verify message is displayed    successfully removed
    Logout Alarmcfg webpage

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close Browser
