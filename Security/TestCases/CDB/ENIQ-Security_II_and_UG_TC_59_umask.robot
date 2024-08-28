*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String

*** Test Cases ***
Verifying umask for root user
    ${umask_root}=       Execute Command              su -c 'umask' -l root
    Should Be Equal      ${umask_root}                0022

Verifying umask for dcuser
    ${umask_dcuser}=       Execute Command              su -c 'umask' -l dcuser
    Should Be Equal        ${umask_dcuser}              0027

Verifying umask for custom user
    ${user_creation}=              Execute Command              useradd dummy_user
    ${umask_user_shadow}=          Execute Command              su -c 'umask' -l dummy_user
    Should Be Equal                ${umask_user_shadow}         0027

Deleting the user
    ${user_creation}=              Execute Command              userdel dummy_user
