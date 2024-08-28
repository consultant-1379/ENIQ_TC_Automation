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
    Should Contain      ${latest_patch}    XS82ECU1001
    Should Contain      ${latest_patch}    XS82ECU1002
    Should Contain      ${latest_patch}    XS82ECU1003
    Should Contain      ${latest_patch}    XS82ECU1004
    Should Contain      ${latest_patch}    XS82ECU1005
    Should Contain      ${latest_patch}    XS82ECU1006
    Should Contain      ${latest_patch}    XS82ECU1007
    Should Contain      ${latest_patch}    XS82ECU1009
    Should Contain      ${latest_patch}    XS82ECU1010
    Should Contain      ${latest_patch}    XS82ECU1012
    Should Contain      ${latest_patch}    XS82ECU1014
    log                 ${latest_patch}



*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}