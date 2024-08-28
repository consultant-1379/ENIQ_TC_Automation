*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection

*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}

*** Test Cases ***
vCPUs-allocated
    Login to Citrix Hypervisor
    ${adds_uuid}=    Execute Command    xe vm-list name-label=ADDS | awk '/uuid/ { print $5 }'
    ${adds_vCPUs}=    Execute Command    xe vm-param-list uuid=${adds_uuid} | grep VCPUs-max | awk '// { print $4 }'
    Should Contain    ${adds_vCPUs}    2
    log    vCPUs allocated for ADDS is ${adds_vCPUs}

    ${ccs_uuid}=    Execute Command    xe vm-list name-label=CCS | awk '/uuid/ { print $5 }'
    ${ccs_vCPUs}=    Execute Command    xe vm-param-list uuid=${ccs_uuid} | grep VCPUs-max | awk '// { print $4 }'
    Should Contain    ${ccs_vCPUs}    2
    log    vCPUs allocated for CCS is ${ccs_vCPUs}

    ${vda_uuid}=    Execute Command    xe vm-list name-label=VDA | awk '/uuid/ { print $5 }'
    ${vda_vCPUs}=    Execute Command    xe vm-param-list uuid=${vda_uuid} | grep VCPUs-max | awk '// { print $4 }'
    Should Contain    ${vda_vCPUs}    32
    log    vCPUs allocated for VDA is ${vda_vCPUs}

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}