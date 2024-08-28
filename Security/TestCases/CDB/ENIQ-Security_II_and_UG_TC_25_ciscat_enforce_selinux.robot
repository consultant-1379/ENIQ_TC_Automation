*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            SSHLibrary  10 seconds
#ZAHAPBR
*** Test Cases ***
Test to check SELinux enforced in enforce selinux
    ${result}=    Execute Command    getenforce
    Should Be Equal    ${result}     Enforcing

Test to check SELinux not enforced in enforce selinux
    ${result}=    Execute Command    setenforce permissive
    ${status}=    Execute Command    getenforce
    Should Be Equal    ${status}     Permissive

Rolling back the SElinux to enforcing
    ${result}=    Execute Command    setenforce enforcing
    ${status}=    Execute Command    getenforce
    Should Be Equal    ${status}     Enforcing

*** Keywords ***
Checking the parameter
    [Arguments]    ${filepath}
    SSHLibrary.File Should Exist    ${filepath}
    ${check}=    Execute Command    getenforce
    ${contents}=    OperatingSystem.Get File    ${filepath}
    IF    '${check}' == 'Enforcing'
        IF    'SELINUX=enforcing' in '''${contents}'''
            ${result}=    Execute Command    echo Success
        ELSE
            ${result}=    Execute Command    echo Failed
        END
    ELSE
        ${result}=    Execute Command    echo Failed
    END
    [Return]    ${result}