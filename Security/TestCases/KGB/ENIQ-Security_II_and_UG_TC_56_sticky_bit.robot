*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test sticky bit not set for /etc    
    ${result}=               Execute Command              chmod -t /etc
    ${cmd}=                  Execute Command              ls -ld /etc | head -n 1 | cut -d'.' -f1
    ${get_lines_mat}=        Get Lines Matching Regexp    ${cmd}=       drwxr-xr-x
    Should Be Equal          ${cmd}                       drwxr-xr-x
    ${result_1}=             Execute Command              chmod +t /etc

Test sticky bit of folder /etc    
    ${result}=               Execute Command              ls -ld /etc | head -n 1 | cut -d'.' -f1
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}=       drwxr-xr-t
    Should Be Equal          ${result}       drwxr-xr-t
