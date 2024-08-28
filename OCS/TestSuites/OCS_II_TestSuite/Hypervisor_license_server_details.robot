*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection

*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}
${CCSIpAddress}

*** Test Cases ***
License Server details
    Login to Citrix Hypervisor
    ${xenserver_uuid}=      Execute Command     xe host-list | grep uuid | awk '/uuid/ { print $5 }'
    ${license_output}=      Execute Command     xe host-list uuid="${xenserver_uuid}" params=all | awk '/license-server/ { print $6 }' | cut -d ";" -f1
    Should Contain          ${license_output}   ${CCSIpAddress}
    log                     Expected license server (${license_output}) and provided license server (${CCSIpAddress}) details are matched.


*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}