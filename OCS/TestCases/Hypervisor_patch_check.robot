*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Variables/OCS_Variables.robot
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection



*** Test Cases ***
Hypervisor Patch check
    Login to Citrix Hypervisor
    ${latest_patch}=    Execute Command     xe patch-list | grep "CH82ECU1" | awk '/name-label/ { print $4 }'
    Should Contain      ${latest_patch}     ${HypervisorPatch}
    log                 ${latest_patch}



*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}