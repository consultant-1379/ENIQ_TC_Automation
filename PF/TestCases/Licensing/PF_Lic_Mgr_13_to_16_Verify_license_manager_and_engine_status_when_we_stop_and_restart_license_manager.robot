*** Settings ***
Library    SSHLibrary
Library    DateTime
Library    OperatingSystem
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Suite Setup   Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify license manager status when we stop license manager
    Wait Until Keyword Succeeds    2x    10s    Stop License Manager    
    Verify License manager status in server    License manager is not running
    ${current_licmgr_log_file}=    Get licensemanager log file for current date
    Sleep    40s
    Wait Until Keyword Succeeds    3x    40s    Verify licensemanager stopped message in licmgr logs    ${current_licmgr_log_file}
    
Verify engine status when we stop license manager
    ${engine_status}=    Execute Command   /eniq/sw/bin/engine status
    Log To Console     ${engine_status}
    Verify command output    ${engine_status}    Status: active
    Verify command output    ${engine_status}    cache status : initialized
    Verify command output    ${engine_status}    Current Profile: Normal
    Verify command output    ${engine_status}    engine is running OK
    Verify command output    ${engine_status}    lwp helper is running

Verify license manager status when we restart license manager
    Wait Until Keyword Succeeds    2x    10s    Restart License Manager
    Verify License manager status in server    License manager is running OK
    
Verify engine status when we restart license manager
    ${engine_status}=    Execute Command   /eniq/sw/bin/engine status
    Log To Console     ${engine_status}
    Verify command output    ${engine_status}    Status: active
    Verify command output    ${engine_status}    cache status : initialized
    Verify command output    ${engine_status}    Current Profile: Normal
    Verify command output    ${engine_status}    engine is running OK
    Verify command output    ${engine_status}    lwp helper is running
    [Teardown]    Test Teardown   

*** Keywords ***
Test Teardown
    ${license_return_status}=    Run Keyword And Return Status    Verify License manager status in server    License manager is running OK    
    IF    ${license_return_status} == True
        Log To Console    License manager status is OK    
    ELSE
        Wait Until Keyword Succeeds    2x    10s    Start License Manager
        Verify License manager status in server    License manager is running OK
    END





