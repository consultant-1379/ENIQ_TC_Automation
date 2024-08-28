*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Test Cases ***
Verify 15min Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    15min
    Verify Interface page is displayed    15min
    Verify target reports are not added    ${15min_basetable}    ${15min_alm_template}    15min
    Click Add report button
    Select alarm template from available reports    ${15min_alm_template}
    Select basetable from dropdown list    ${15min_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${15min_basetable}    ${15min_alm_template}

Verify 15min Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    15min    ${15min_basetable}    ${15min_alm_template}
    Verify message is displayed    successfully disabled

Verify 15min Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    15min    ${15min_basetable}    ${15min_alm_template}
    Verify message is displayed    successfully enabled

Verify 15min Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    15min    ${15min_basetable}    ${15min_alm_template}
    Verify message is displayed    successfully removed
    Logout Alarmcfg webpage
    
    
*** Keywords ***
Suite setup steps
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close All Browsers

