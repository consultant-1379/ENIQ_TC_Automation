*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}


*** Test Cases ***
VM_base_template_name
    Login to Citrix Hypervisor
    
    ${adds_uuid}=    Execute Command    xe vm-list name-label=ADDS | awk '/uuid/ { print $5 }'
    ${os_version_name}=    Execute Command    xe vm-param-list uuid=${adds_uuid} | grep reference-label | awk '// { print $4 }'
    Should Contain    ${os_version_name}    windows-server-2016-64bit
    log    Windows OS configured in ADDS is ${os_version_name}

    ${ccs_uuid}=    Execute Command    xe vm-list name-label=CCS | awk '/uuid/ { print $5 }'
    ${os_version_name}=    Execute Command    xe vm-param-list uuid=${ccs_uuid} | grep reference-label | awk '// { print $4 }'
    Should Contain    ${os_version_name}    windows-server-2016-64bit
    log    Windows OS configured in CCS is ${os_version_name}
    
    ${vda_uuid}=    Execute Command    xe vm-list name-label=VDA | awk '/uuid/ { print $5 }'
    ${os_version_name}=    Execute Command    xe vm-param-list uuid=${vda_uuid} | grep reference-label | awk '// { print $4 }'
    Should Contain    ${os_version_name}    windows-server-2016-64bit
    log    Windows OS configured in VDA is ${os_version_name}


*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}