*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify license manager status when we start license manager
    Wait Until Keyword Succeeds    2x    10s    Start License Manager
    ${licmgr_status}=    Execute Command    /eniq/sw/bin/licmgr -status
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    License manager is running OK
    
Verify engine status when we start license manager
    ${engine_status}=    Execute Command   /eniq/sw/bin/engine status
    Log To Console     ${engine_status}
    Verify command output    ${engine_status}    Status: active
    Verify command output    ${engine_status}    cache status : initialized
    Verify command output    ${engine_status}    Current Profile: Normal
    Verify command output    ${engine_status}    engine is running OK
    Verify command output    ${engine_status}    lwp helper is running
   
    


