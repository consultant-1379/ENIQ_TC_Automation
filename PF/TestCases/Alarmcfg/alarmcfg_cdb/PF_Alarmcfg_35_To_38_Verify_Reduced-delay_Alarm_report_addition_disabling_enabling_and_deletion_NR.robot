*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Variables ***



*** Test Cases ***
Verify Reduced delay Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    Reduced Delay
    Verify Interface page is displayed    Reduced Delay
    Verify target reports are not added    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}    Reduced Delay
    Click Add report button
    Select alarm template from available reports    ${Reduced_delay_alm_template}
    Select basetable from dropdown list    ${Reduced_delay_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}

Verify Reduced delay Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    Reduced Delay    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}
    Verify message is displayed    successfully disabled

Verify Reduced delay Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    Reduced Delay    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}
    Verify message is displayed    successfully enabled

Verify Reduced delay Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    Reduced Delay    ${Reduced_delay_basetable}    ${Reduced_delay_alm_template}
    Verify message is displayed    successfully removed
    Logout Alarmcfg webpage
    
    
*** Keywords ***
Suite setup steps
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close Browser

