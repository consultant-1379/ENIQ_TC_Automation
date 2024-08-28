*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup     suite setup for repostory
Suite Teardown     Close All Connections

*** Test Cases ***
Check password policies for repdb user
    Verify password policies for repdb user
Check repdb_user_password log file is created 
    Verify repdb_user_password log file is created 
Restart all services after changing passwords
    ${check_engine}=    Wait Until Keyword Succeeds    2x    10s    Verify Restart all services after changing passwords
    
Check status of all services
    check status of all services

*** Keywords ***
Verify password policies for repdb user    
    Execute command    cd /eniq/sw/platform/repository-*/bin  && chmod +x ChangeUserPasswordsInRepdb
    Write    cd /eniq/sw/platform/repository-*/bin && ./ChangeUserPasswordsInRepdb -u dcuser    
    Read    delay=2s
    Write    ${pass_for_vapp}
    Read    delay=2s
    Write   ${pass_for_vapp}
    Read    delay=2s
    Write   ${pass_for_vapp}
    ${output}    Read until prompt    strip_prompt=True
    Should Contain    ${output}    Password updated successfully

Verify repdb_user_password log file is created 
    ${date}    Execute Command    date '+%d.%m.%Y'
    ${logfile}    Execute Command    cd /eniq/log/sw_log/engine/ && ls -lrth repdb_user_password_*${date}.log
    Should Contain    ${logfile}    repdb

Verify Restart all services after changing passwords
    #Connect to physical server as root user with prompt
    Write    bash /eniq/admin/bin/manage_deployment_services.bsh -a restart -s ALL    
    Read    delay=2s
    Write    Yes
    ${output}    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    ENIQ services started correctly 

check status of all services
    ${output}    Execute Command    bash /eniq/admin/bin/manage_deployment_services.bsh -a list -s ALL
    Log    ${output}
    ${out_value}    Evaluate    """inactive""" in """${output}"""
    IF    '${out_value}' == 'False'
        Pass Execution    All the services are active
    ELSE
        Fail
    END

suite setup for repostory
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=7m    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#:    
    Login    ${root_user}    ${root_pwd}
