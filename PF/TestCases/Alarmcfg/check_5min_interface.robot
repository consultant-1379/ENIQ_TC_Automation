*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps


*** Test Cases ***
Verify 5min Interface Alarm report addition
    Launch Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Click Interface link    5min
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
    

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Capture Page Screenshot
    Close Browser

Verify target reports are not added
    [Arguments]    ${intf_basetable_args}    ${alm_template_args}     ${alm_intf_time_args}
    ${check_interface_empty}=    Run Keyword And Return Status    Element Should Contain    id:action_title    ${alm_intf_time_args}
    IF    ${check_interface_empty} == True
        # Log    No reports are present
        ${count_added_reports}=    Get Element Count    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]   
        IF    ${count_added_reports} == 0
            Log    Adding reports
        ELSE
            FOR    ${counter}    IN RANGE    0    ${count_added_reports}    
                Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Remove"]
                Handle Alert    timeout=10s  
                Verify message is displayed    successfully removed     
                Sleep    2s
            END   
            Click Interface link     ${alm_intf_time_args}
            Page Should Not Contain Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]     
            END
    ELSE
        Log    Click Link not worked    
    END
    


Verify alarm report addition
    [Arguments]    ${intf_basetable_args}    ${alm_template_args}
    ${rows_count}=    Count alarm report table rows
    ${alm_report_status}=    Run Keyword And Return Status    Page Should Contain Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]   
    [Return]     ${alm_report_status}
    Sleep    2s
    
Disable Alarm report
    [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}  
    Set time delay      
    Click Interface link     ${interface_link_args}    
    ${rows_count}=    Count alarm report table rows
    Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Disable"]
    Capture Page Screenshot
    Sleep    2s

Enable Alarm report
    [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}
    Set time delay 
    Click Interface link    ${interface_link_args}
    ${rows_count}=    Count alarm report table rows
    Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Enable"]
    Capture Page Screenshot
    Sleep    2s

Delete Alarm report
    [Arguments]    ${interface_link_args}    ${intf_basetable_args}    ${alm_template_args}
    Set time delay 
    Click Interface link    ${interface_link_args} 
    ${rows_count}=    Count alarm report table rows
    Click Element    xpath://tr[td[text()="${intf_basetable_args}"] and td[text()="${alm_template_args}"]]//img[@alt="Remove"]
    Handle Alert    timeout=10s   
    Capture Page Screenshot
    Sleep    2s

Launch Alarmcfg webpage
    [Arguments]    ${login_url_args}
    Set time delay
    Open Available Browser    ${login_url_args}    options=set_capability("acceptInsecureCerts", True)
    Maximize Browser Window

Launch Alarmcfg webpage in browser
    Launch Alarmcfg webpage    ${login_almcfg_url} 