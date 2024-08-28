*** Settings ***
Suite Setup        Open Connection and Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Open Connection And Log In to Reader2
    [Tags]                                 Size_of_directory
    Open Connection                        ${host3}                          port=${PORT3}
    Login                                  ${username3}                      ${password3}    delay=1
    Log To Console                         Connected to server ${host3}:${p3}

Check if directory size /eniq/local_logs/counter_tool/ is not greater than 90%
    [Tags]                                 Size_of_directory
    Set Client Configuration               timeout=25 seconds                  prompt=#:    
    ${output}=                             Execute Command                     df -hk /eniq/local_logs/counter_tool/ | grep "log" | awk -F " " '{print $5}' | tail -l | cut -d "%" -f1     
    ${size}=                               Convert To Integer                  ${output}
	${flag}=                               Set Variable                        0
    IF                                     ${size}>90
    Set Variable                           ${flag}=1
    END
    Should Be Equal                        ${flag}                             0
