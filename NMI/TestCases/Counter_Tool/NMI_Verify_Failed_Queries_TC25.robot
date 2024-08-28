*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Open Connection And Log In to Reader II
    [Tags]                                 Counter Tool
    Open Connection                        ${host3}                          port=${PORT3}
    Login                                  ${username3}                      ${password3}    delay=1
    Log To Console                         Connected to server ${host3}:${p3}

Check if any failed queries are present
    [Tags]                                 Counter Tool
    Set Client Configuration               timeout=25 seconds                  prompt=#:    
    ${output}=                             Execute Command                     grep "failed_parsed_queries" /eniq/local_logs/counter_tool/counter_statistics_tool_*  
    Should not Contain                     ${output}                           Failed to parse few queries
