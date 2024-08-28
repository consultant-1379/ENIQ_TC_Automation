*** Settings ***
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection

*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}

*** Test Cases ***

Virtual Machines Storage check
    Login to Citrix Hypervisor
    ${SERVER_TYPE}=     Execute Command     dmidecode -t system | awk '/Product Name/ { print $4 }' | cut -c1-2
    IF  "${SERVER_TYPE}" == "BL"
        log                 "Server type is Blade."

        ${adds_storage}=     Execute Command     xe vm-disk-list vm=ADDS | awk '/virtual-size/ { print $4 }'
        Should Contain      ${adds_storage}      107374182400
        log                 ${adds_storage}

        ${ccs_storage}=      Execute Command     xe vm-disk-list vm=CCS | awk '/virtual-size/ { print $4 }'
        Should Contain      ${ccs_storage}       214748364800
        log                 ${ccs_storage}

        ${vda_storage}=      Execute Command     xe vm-disk-list vm=VDA | awk '/virtual-size/ { print $4 }'
        Should Contain      ${vda_storage}       214748364800
        log                 ${vda_storage}
    END

    IF  "${SERVER_TYPE}" == "DL"
        log                 "Server type is Rack."

        ${adds_storage}=     Execute Command     xe vm-disk-list vm=ADDS | awk '/virtual-size/ { print $4 }'
        Should Contain      ${adds_storage}      53687091200
        log                 ${adds_storage}

        ${ccs_storage}=      Execute Command     xe vm-disk-list vm=CCS | awk '/virtual-size/ { print $4 }'
        Should Contain      ${ccs_storage}       107374182400
        log                 ${ccs_storage}

        ${vda_storage}=      Execute Command     xe vm-disk-list vm=VDA | awk '/virtual-size/ { print $4 }'
        Should Contain      ${vda_storage}       107374182400
        log                 ${vda_storage}
    END

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}