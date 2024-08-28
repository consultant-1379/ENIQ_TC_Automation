*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Check if directory size /eniq/log/log_collector/ is not greater than 80%
    [Tags]      Log_Collector  
    Set Client Configuration          timeout=25 seconds     prompt=#:    
    ${output}=                        Execute Command        df -hk /eniq/log/log_collector/ | grep "log" | awk -F " " '{print $5}' | tail -l | cut -d "%" -f1
    ${size}=                          Convert To Integer     ${output}
    ${flag}=                          Set Variable           0
    IF                                ${size}>80
    Set Variable                      ${flag}=1
    END
    Should Be Equal                   ${flag}                0

Check if directory size /eniq/local_logs/log_collector/ is not greater than 80%
    [Tags]      Log_Collector  
    Set Client Configuration        timeout=25 seconds       prompt=#:    
    ${output}=                      Execute Command          df -hk /eniq/local_logs/log_collector/ | grep "log" | awk -F " " '{print $5}' | tail -l | cut -d "%" -f1
    ${size}=                        Convert To Integer       ${output}
    ${flag}=                        Set Variable             0
    IF                              ${size}>80
    Set Variable                    ${flag}=1
    END
    Should Be Equal                 ${flag}                  0
