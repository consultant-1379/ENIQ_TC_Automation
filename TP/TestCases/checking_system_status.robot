*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***

*** Test Cases ***
checking system status
    checking services
*** Keywords ***
checking services
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    services -s eniq
    ${output}=    Read Until Prompt
    ${other_Status}    System Status    ${output}
    IF    ${other_Status} == []
        Log To Console    Everything is working fine
        Write    engine -e status
        ${output2}=    Read Until Prompt 
        ${engine_profile}=    Getting Engine Profile    ${output2}
        IF    '${engine_profile}' == 'Current Profile: NoLoads'
            Write    engine -e changeProfile 'Normal'
            ${output3}=    Read Until Prompt
            ${contains}=    Run Keyword And Return Status    Should Contain    ${output3}    Change profile requested successfully
            IF    '${contains}' != 'True'
                Fail
            END
        END
    ELSE
        Log To Console    ${other_Status}services${SPACE}are${SPACE}down
        IF    ${other_Status} == ['eniq-engine']
            Log To Console    only engine service is down
            Write    engine restart
            ${output1}=    Read Until Prompt
            Write    engine -e status
            ${output2}=    Read Until Prompt 
            ${engine_profile}=    Getting Engine Profile    ${output2}
            IF    '${engine_profile}' == 'Current Profile: NoLoads'
                Write    engine -e changeProfile 'NoLoads'
                ${output3}=    Read Until Prompt
                ${contains}=    Run Keyword And Return Status    Should Contain    ${output3}    Change profile requested successfully
                IF    '${contains}' != 'True'
                    Fail
                END
            END         
        ELSE
            Fail
        END

    END
    