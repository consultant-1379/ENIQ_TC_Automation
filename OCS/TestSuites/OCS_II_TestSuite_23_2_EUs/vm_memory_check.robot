*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}

*** Test Cases ***
Virtual Machines Memory check
    Login to Citrix Hypervisor
    ${SERVER_TYPE}=     Execute Command     dmidecode -t system | awk '/Product Name/ { print $4 }' | cut -c1-2
    IF  "${SERVER_TYPE}" == "BL"
        log                 "Server type is Blade."
        ${adds_uuid}=       Execute Command     xe vm-list name-label=ADDS | awk '/uuid/ { print $5 }'
        ${adds_memory}=     Execute Command     xe vm-param-get uuid=${adds_uuid} param-name=memory-static-{min,max}
        Should Contain      ${adds_memory}      17179869184
        log                 ${adds_memory}

        ${ccs_uuid}=        Execute Command     xe vm-list name-label=CCS | awk '/uuid/ { print $5 }'
        ${ccs_memory}=      Execute Command     xe vm-param-get uuid=${ccs_uuid} param-name=memory-static-{min,max}
        Should Contain      ${ccs_memory}       17179869184
        log                 ${ccs_memory}

        ${vda_uuid}=        Execute Command     xe vm-list name-label=VDA | awk '/uuid/ { print $5 }'
        ${vda_memory}=      Execute Command     xe vm-param-get uuid=${vda_uuid} param-name=memory-static-{min,max}
        Should Contain      ${vda_memory}       206158430208
        log                 ${vda_memory}
    END

    IF  "${SERVER_TYPE}" == "DL"
        log                 "Server type is Rack."
        ${adds_uuid}=       Execute Command     xe vm-list name-label=ADDS | awk '/uuid/ { print $5 }'
        ${adds_memory}=     Execute Command     xe vm-param-get uuid=${adds_uuid} param-name=memory-static-{min,max}
        Should Contain      ${adds_memory}      17179869184
        log                 ${adds_memory}

        ${ccs_uuid}=        Execute Command     xe vm-list name-label=CCS | awk '/uuid/ { print $5 }'
        ${ccs_memory}=      Execute Command     xe vm-param-get uuid=${ccs_uuid} param-name=memory-static-{min,max}
        Should Contain      ${ccs_memory}       17179869184
        log                 ${ccs_memory}

        ${vda_uuid}=        Execute Command     xe vm-list name-label=VDA | awk '/uuid/ { print $5 }'
        ${vda_memory}=      Execute Command     xe vm-param-get uuid=${vda_uuid} param-name=memory-static-{min,max}
        Should Contain      ${vda_memory}       68719476736
        log                 ${vda_memory}
    END

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}