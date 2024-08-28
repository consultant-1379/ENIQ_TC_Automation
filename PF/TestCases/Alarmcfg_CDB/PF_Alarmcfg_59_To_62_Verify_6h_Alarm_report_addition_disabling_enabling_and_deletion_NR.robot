*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Test Cases ***
Verify 6h Interface Alarm report addition
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${cdb_almcfg_sys}    ${cdb_almcfg_user}    ${cdb_almcfg_pass}    ${cdb_almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Click Interface link    6h
    Verify Interface page is displayed    6h
    Verify target reports are not added    ${cdb_basetable}    ${cdb_alm_template}    6h
    Click Add report button
    Select alarm template from available reports    ${cdb_alm_template}
    Select basetable from dropdown list    ${cdb_basetable}
    Click Add alarm report button
    Verify alarm report addition     ${cdb_basetable}    ${cdb_alm_template}

Verify 6h Interface Alarm report disabled
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Disable Alarm report    6h    ${cdb_basetable}    ${cdb_alm_template}
    Verify message is displayed    successfully disabled

Verify 6h Interface Alarm report enabled
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Enable Alarm report    6h    ${cdb_basetable}    ${cdb_alm_template}
    Verify message is displayed    successfully enabled

Verify 6h Interface Alarm report deletion
    Skip if    '${PREV TEST STATUS}'=='SKIP'
    Delete Alarm report    6h    ${cdb_basetable}    ${cdb_alm_template}
    Verify message is displayed    successfully removed
    Logout Alarmcfg webpage
    
    
*** Keywords ***
Suite setup steps
    Skip If    ${almcfg_config_status}==False
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close Browser

