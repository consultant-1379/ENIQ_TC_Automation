*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}


*** Test Cases ***
Virtual Machines list
    Login to Citrix Hypervisor
    ${adds}=            Execute Command     xe vm-list name-label=ADDS
    Should Contain      ${adds}             name-label ( RW): ADDS
    log                 ${adds}

    ${ccs}=             Execute Command     xe vm-list name-label=CCS
    Should Contain      ${ccs}              name-label ( RW): CCS
    log                 ${ccs}

    ${vda}=             Execute Command     xe vm-list name-label=VDA
    Should Contain      ${vda}              name-label ( RW): VDA
    log                 ${vda}

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}