*** Settings ***
Library           SSHLibrary
Library           RPA.Browser.Selenium
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Variables.robot

*** Keywords ***
Connection to physical server
    ${prompt_pysical_server}    Set Variable    ${SERVER}${prompt}
    ${dcuser}    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=100s    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{dcuser\\}\\s#:
    Login    ${user_for_vapp}    ${pass_for_vapp}
    Set Global Variable    ${dcuser}

 Switch to root user and execute systemctl command
    ${root}    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=100s   
    Login    ${root_user}     ${root_pwd}
    ${eniq_scheduler_status}    Execute Command    cd /root && systemctl status eniq-scheduler.service
    Switch Connection    ${dcuser}
    RETURN    ${eniq_scheduler_status}
	
Get Scheduler Rstate from clearcase
    [Arguments]    ${scheduler_file}
    ${scheduler_zip_file}=    Fetch from Right    ${scheduler_file}    _
    ${scheduler_rstate_buildno_clearcase}=    Fetch From Left    ${scheduler_zip_file}    .
    RETURN    ${scheduler_rstate_buildno_clearcase}

Get Scheduler version from server
    ${rstate_8399}    Execute Command    cd /eniq/sw/installer && cat versiondb.properties | grep -i scheduler
    ${scheduler_rstate}    Split String    ${rstate_8399}    scheduler=
    ${scheduler_rstate_buildno_server}=    Get From List    ${scheduler_rstate}    -1
    RETURN    ${scheduler_rstate_buildno_server}

Verify the latest sceduler version is updated in versiondb.properties file
    [Arguments]    ${rstate_clearcase}    ${scheduler_rstate_8399}
    IF    '${rstate_clearcase}' == '${scheduler_rstate_8399}'
        RETURN    True
    ELSE
        RETURN    False
    END

Get the element of Scheduler attribute from clearcase
    Open Available Browser    ${clearcase_url}     headless=false
    Maximize Browser Window
    click link    //body//tr[last()-2]//td[2]//a
    ${scheduler_file}=    Get Element Attribute    //a[contains(text(),'scheduler')]    href
    Go To    ${scheduler_file}
    RETURN    ${scheduler_file}

Install latest scheduler package
    [Arguments]    ${scheduler_file}
    Execute Command     cd /eniq/sw/installer/ && rm -rf scheduler_*
    ${scheduler_zip_file}=    Fetch from Right    ${scheduler_file}    /
    Execute Command    cd /eniq/sw/installer/ && wget ${scheduler_file}
    Execute Command    cd /eniq/sw/installer/ && chmod u+x ${scheduler_zip_file}
    Write    cd /eniq/sw/installer/ ; ./platform_installer ${scheduler_zip_file}
    ${staus_scheduler}=    Read Until Prompt
    RETURN    ${staus_scheduler}

Verify Successfully installation of scheduler package
    [Arguments]    ${staus_scheduler}
    Should Contain    ${staus_scheduler}    Successfully installed

Stop Scheduler
    Write     cd /eniq/sw/installer ; scheduler stop
    ${scheduler_deactivate}    Read until prompt

Verify scheduler is deactivated
    [Arguments]    ${scheduler_status}    ${systemctl_command}
    Should Contain    ${scheduler_status}    scheduler is not running
    Should Contain    ${systemctl_command}    Active: inactive (dead)

Fetch Scheduler status
    Write    cd /eniq/sw/installer && scheduler status
    ${scheduler_status}    Read until prompt
    ${eniq_scheduler_status}    Switch to root user and execute systemctl command
    RETURN    ${scheduler_status}    ${eniq_scheduler_status}

Verify the stop_scheduler logs when we stop scheduler
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep stop_scheduler_${date} | tail -1
    ${output}	${rc}=		Execute Command    cd /eniq/log/sw_log/scheduler && grep -iE 'error|exception|warning|server not found' ./${scheduler_file}    return_rc=True
    ${output_length}    Get Length    ${output}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "scheduler is not running"
    ELSE
         Fail    ${output}
    END

Start Scheduler
    Write     cd /eniq/sw/installer ; scheduler start
    ${scheduler_activate}    Read until prompt

Restart Scheduler
    Write     cd /eniq/sw/installer ; scheduler restart
    ${scheduler_restart}    Read until prompt

Activate Scheduler
    Write     cd /eniq/sw/installer ; scheduler activate
    ${scheduler_activate}    Read until prompt
    


Verify scheduler is activated
    [Arguments]    ${scheduler_status}    ${systemctl_command}
    Should Contain    ${scheduler_status}    Status: active
    Should Contain    ${systemctl_command}    Active: active (running)

Verify the start_scheduler logs when we start scheduler
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep start_scheduler_${date} | tail -1
    ${output}	${rc}=		Execute Command		cd /eniq/log/sw_log/scheduler && grep -i -E 'exception|error|server not found' ./${scheduler_file}		return_rc=True
    ${output_length}    Get Length    ${output}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "scheduler is running"
    ELSE
         Fail    ${output}
    END

Fetch engine status
    Write     cd /eniq/sw/installer ; engine status
    ${engine_status}    Read until prompt
    ${eniq_engine_status}    Execute command    systemctl status eniq-engine.service
    RETURN    ${engine_status}    ${eniq_engine_status}

Stop engine
    Write     cd /eniq/sw/installer ; engine stop
    ${engine_status}    Read until prompt

Start engine
    Write     cd /eniq/sw/installer && engine start
    ${engine_status}    Read until prompt

Verify engine status when scheduler goes down
    [Arguments]    ${engine_status}    ${systemctl_command_engine}    ${scheduler_status}    ${systemctl_command}
    ${check_scheduler_status}    Run Keyword And Return Status    Should Contain    ${scheduler_status}    scheduler is not running
    ${eniq_scheduler_status}    Run Keyword And Return Status    Should Contain    ${systemctl_command}    Active: inactive (dead)
    IF   '${check_scheduler_status}' == 'True' and '${eniq_scheduler_status}' == 'True'
        ${check_engine_status}    Run Keyword And Return Status    Should Contain    ${engine_status}    engine is running OK
        # ${eniq_engine_status}    Run Keyword And Return Status    Should Contain    ${systemctl_command_engine}    Active: active (running)
        # IF    '${check_engine_status}' == 'True' and '${eniq_engine_status}' == 'True'
        IF    '${check_engine_status}' == 'True'
            Log To Console    Engine should be active when scheduler is down
        ELSE
            Fail   Engine is not active  when scheduler is down
        END
    ELSE
        Fail   Scheduler is not active  when engine is down
    END

Verify scheduler status when engine is down
    [Arguments]    ${engine_status}    ${systemctl_command_engine}    ${scheduler_status}    ${systemctl_command}
    ${check_engine_status}    Run Keyword And Return Status    Should Contain    ${engine_status}    engine is not running
    ${eniq_engine_status}    Run Keyword And Return Status    Should Contain    ${systemctl_command_engine}    Active: inactive (dead)
    IF   '${check_engine_status}' == 'True' and '${eniq_engine_status}' == 'True'
        ${check_scheduler_status}    Run Keyword And Return Status    Should Contain    ${scheduler_status}    scheduler is running OK
        ${eniq_scheduler_status}    Run Keyword And Return Status    Should Contain    ${systemctl_command}    Active: active (running)
        IF    '${check_scheduler_status}' == 'True' and '${eniq_scheduler_status}' == 'True'
            Log To Console    Sheduler should be active when engine is down
            Start engine
        ELSE
            Start engine
            Fail   Scheduler is not active  when engine is down
        END
    ELSE
        Start engine
        Fail   Scheduler is not active  when engine is down
    END

Verify scheduler is ON HOLD
    [Arguments]    ${scheduler_status}    ${eniq_scheduler_status}
    ${check_scheduler_status}    Run Keyword And Return Status    Should Contain    ${scheduler_status}    Status: on hold
    ${eniq_scheduler_status}    Run Keyword And Return Status    Should Contain    ${eniq_scheduler_status}    Active: active (running)
    RETURN    ${check_scheduler_status}

Hold Scheduler and check scheduler log after holding
    ${date}    Execute Command     date '+%Y_%m_%d'
    Write     cd /eniq/log/sw_log/scheduler && scheduler hold|true && d=$(date '+%H:%M:%S') && cat scheduler-${date}.log | grep -i $d | grep -iE 'on hold'
    ${hold_scheduler}    Read Until Prompt
    ${hold_scheduler_status}    Run Keyword And Return Status    Should Contain    ${hold_scheduler}    on hold    ignore_case=True
    RETURN    ${hold_scheduler_status}

Stop Scheduler and check engine logs
    ${date}    Execute Command     date '+%Y_%m_%d'
    Write    cd /eniq/log/sw_log/engine && scheduler stop|true && d=$(date '+%H:%M:%S') && cat engine-${date}.log | grep -i $d | grep -i -E 'exception|error|server not found' 
    ${stop_scheduler_status}    Read Until Prompt    strip_prompt=True
    ${length_scheduler_status}    Get Length    ${stop_scheduler_status}
    IF    ${length_scheduler_status} != 0
        Fail    Error or exception found when stopping scheduler
    END

Stop Scheduler and verify for not parsing any files in engine logs
    ${date}    Execute Command     date '+%Y_%m_%d'
    Write    cd /eniq/log/sw_log/engine && scheduler stop|true && d=$(date '+%H:%M:%S') && cat engine-${date}.log | grep -i $d | grep -i -E 'parsed\|loaded'
    ${stop_scheduler_status}    Read Until Prompt    strip_prompt=True
    ${length_scheduler_status}    Get Length    ${stop_scheduler_status}
    IF    ${length_scheduler_status} != 0
        Fail    Parsing is not stopped when scheduler is down
    END

Switch to root user
    ${root}    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=30    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{root\\}\\s#:    alias=root
    Login    root     ${root_pwd}

Verify scheduler status latest
    ${check_sch_status}=    Execute Command    /eniq/sw/bin/scheduler status
    Should Contain    ${check_sch_status}    Status: active
    # Should Contain    ${check_sch_status}    Active: active (running)

Iterating for 3 minutes
    [Arguments]    ${check_status}    ${msg}    
    ${date}    Execute Command    date +"%H:%M"
    ${date_3minutes}    Execute Command    date -d "3 minutes" +'%H:%M'  
    FOR    ${counter}    IN RANGE    0    6    1
        IF    '${date}' <= '${date_3minutes}'
            Write    ${check_status}
            ${check_status}    Read    delay=50s
            Log    ${check_status}
            ${status}    Run Keyword And Return Status    Should Contain    ${check_status}    ${msg}   
            ${date}    Execute Command    date +"%H:%M"
            IF    '${status}' == 'True'
                RETURN    True
            ELSE
                Continue For Loop
            END
        ELSE
            Fail    
        END
    END