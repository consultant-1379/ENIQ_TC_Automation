*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}

*** Test Cases ***
Hypervisor_version
    Login to Citrix Hypervisor
    ${output}=          Execute Command     cat /etc/redhat-release
    Should Contain      ${output}           Citrix Hypervisor release 8.2.1 (xenenterprise)
    log                 ${output}

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}