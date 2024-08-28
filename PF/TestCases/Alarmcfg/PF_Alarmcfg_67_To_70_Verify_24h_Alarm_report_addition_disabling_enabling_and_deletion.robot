*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Test Cases ***
Verify 24h Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    24h
    Verify Interface page is displayed    24h
    Verify target reports are not added    ${24h_basetable}    ${24h_alm_template}    24h
    Click Add report button
    Select alarm template from available reports    ${24h_alm_template}
    Select basetable from dropdown list    ${24h_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${24h_basetable}    ${24h_alm_template}

Verify 24h Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    24h    ${24h_basetable}    ${24h_alm_template}
    Verify message is displayed    successfully disabled

Verify 24h Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    24h    ${24h_basetable}    ${24h_alm_template}
    Verify message is displayed    successfully enabled

Verify 24h Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    24h    ${24h_basetable}    ${24h_alm_template}
    Verify message is displayed    successfully removed
    Logout Alarmcfg webpage
    
    
*** Keywords ***
Suite setup steps
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close All Browsers

