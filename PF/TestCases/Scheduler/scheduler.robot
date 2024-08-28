*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Scheduler.robot
Test Setup    Connection to physical server
Test Teardown    Close All Connections
*** Variables ***
${SERVER}    ieatrcx8398
${host_123}    ${SERVER}.athtem.eei.ericsson.se
*** Test Cases ***
# Verify the Installer version is updated in versiondb.properties
#     ${scheduler_file}    Get the element of Scheduler attribute from clearcase
#     ${scheduler_rstate_buildno_clearcase}    Get Scheduler Rstate from clearcase    ${scheduler_file}
#     ${scheduler_rstate_buildno_server}    Get Scheduler version from server
#     ${rstate_status}    Verify the latest sceduler version is updated in versiondb.properties file    ${scheduler_rstate_buildno_clearcase}    ${scheduler_rstate_buildno_server}
#     Set Global Variable    ${rstate_status}

# Verify the installation of latest scheduler package
#     IF    '${rstate_status}' == 'True'
#         Skip   Scheduler version from clearcase and server is same hence skipping the installation of scheduler package of TC-1
#     ELSE
#         ${scheduler_file}    Get the element of Scheduler attribute from clearcase
#         ${staus_scheduler}    Install latest scheduler package     ${scheduler_file}
#         Verify Successfully installation of scheduler package    ${staus_scheduler}
#     END

Verify the scheduler logs when we stop scheduler
    Stop Scheduler
    ${scheduler_status}    ${eniq_scheduler_status}    Fetch Scheduler status
    Verify scheduler is deactivated    ${scheduler_status}    ${eniq_scheduler_status}
    Verify the stop_scheduler logs when we stop scheduler

Verify engine logs & check for parsing when scheduler goes down
    Stop Scheduler and verify for not parsing any files in engine logs
    ${scheduler_status}    ${eniq_scheduler_status}    Fetch Scheduler status
    Verify scheduler is deactivated    ${scheduler_status}    ${eniq_scheduler_status}

Verify engine status and engine logs when scheduler goes down 
    Stop Scheduler and check engine logs
    ${scheduler_status}    ${eniq_scheduler_status}    Fetch Scheduler status
    ${engine_status}    ${eniq_engine_status}     Fetch engine status
    Verify engine status when scheduler goes down    ${engine_status}    ${eniq_engine_status}    ${scheduler_status}    ${eniq_scheduler_status}  

Verify the scheduler logs when we start scheduler
    Start Scheduler
    ${scheduler_status}    ${eniq_scheduler_status}    Fetch Scheduler status
    Verify scheduler is activated    ${scheduler_status}    ${eniq_scheduler_status}
    Verify the start_scheduler logs when we start scheduler