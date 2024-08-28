*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the loader_DC_Z_ALARM log for Failure
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${almcfg_current_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_Alarminterface_file}=    Execute Command    ls /eniq/log/sw_log/engine/DC_Z_ALARM/ | grep -i file-${almcfg_current_date}.log
    Log    ${check_Alarminterface_file}
    Should Not Be Empty    ${check_Alarminterface_file}
    ${check_data_parsing}=    Execute Command    cat /eniq/log/sw_log/engine/DC_Z_ALARM/file-${almcfg_current_date}.log |grep -i parsed
    Log    ${check_data_parsing}
    Should Not Be Empty    ${check_data_parsing}

    
    
    # ${latest_file}=    Getting latest file from the folder    ${DC_Z_Log_path}    ${latest_engine_file}
    # ${failure_logs}=    Opening the loader_DC_Z_ALARM latest file and checking for failure message  ${latest_file}
    # verify logs should not contain faliure    ${failure_logs}