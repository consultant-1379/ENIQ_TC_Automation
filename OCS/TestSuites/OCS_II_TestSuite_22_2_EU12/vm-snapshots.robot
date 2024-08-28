*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection

*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}

*** Test Cases ***
VM Snapshot verification
    Login to Citrix Hypervisor
    
    ${adds_uuid}=    Execute Command    xe vm-list name-label=ADDS | awk '/uuid/ { print $5 }'
    ${snapshots_list}=    Execute Command    xe vm-param-list uuid=${adds_uuid} | grep snapshots | awk '// { print $4 }'
    Should Be Empty    ${snapshots_list}

    ${ccs_uuid}=    Execute Command    xe vm-list name-label=CCS | awk '/uuid/ { print $5 }'
    ${snapshots_list}=    Execute Command    xe vm-param-list uuid=${ccs_uuid} | grep snapshots | awk '// { print $4 }'
    Should Be Empty    ${snapshots_list}

    ${vda_uuid}=    Execute Command    xe vm-list name-label=VDA | awk '/uuid/ { print $5 }'
    ${snapshots_list}=    Execute Command    xe vm-param-list uuid=${vda_uuid} | grep snapshots | awk '// { print $4 }'
    Should Be Empty    ${snapshots_list}

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}