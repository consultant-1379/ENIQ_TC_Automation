*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt
 
*** Variables ***
 
*** Test Cases ***
Checking whether mws_password_file is present in /eniq/installation/config directory in ENIQ server
    [Tags]                         IPV6_II
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls /eniq/installation/config/mws_password_file
    Should Be Equal                ${output}               /eniq/installation/config/mws_password_file
 
Checking whether mws_password_file is present in /eniq/sw/conf directory in ENIQ server
    [Tags]                         IPV6_II
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output}=                     Execute Command         ls /eniq/sw/conf/mws_password_file
    Should Be Equal                ${output}               /eniq/sw/conf/mws_password_file

Checking whether mws_password_file is same in both the directory path file /eniq/sw/conf and /eniq/installation/config/ in ENIQ server
    [Tags]                         IPV6_II
    Open Connection                ${host}        port=${PORT}
    Login                          ${username}    ${password}    delay=1
    Log To Console                 Connected to server ${host}:${p}
    Set Client Configuration       timeout=25 seconds      prompt=#:
    ${output1}=                    Execute Command         cat /eniq/sw/conf/mws_password_file
    ${output2}=                    Execute Command         cat /eniq/installation/config/mws_password_file
    Should Be Equal                ${output1}               ${output2}
