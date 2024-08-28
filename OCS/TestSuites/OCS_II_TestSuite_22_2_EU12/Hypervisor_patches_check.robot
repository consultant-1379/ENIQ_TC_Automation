*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}


*** Test Cases ***
Hypervisor Patch check
    Login to Citrix Hypervisor
    ${latest_patch}=    Execute Command     xe patch-list | grep name-label | awk '/name-label/ { print $4 }' | sort
    Should Contain      ${latest_patch}    CH82ECU1 
    log                 ${latest_patch}



*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}