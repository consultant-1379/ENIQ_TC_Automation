*** Settings ***
Library    SSHLibrary
Resource    ../Resources/Variables/OCS_Variables.robot
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection



*** Test Cases ***
Citrix Virtual Apps version uploaded to Hypervisor
    Login to Citrix Hypervisor
    ${output}=          Execute Command     ls /var/opt/xen/ISO_Store/ | grep Citrix_Virtual_Apps_and_Desktops_7_1912_LTSR_CU4.iso
    Should Contain      ${output}           Citrix_Virtual_Apps_and_Desktops_7_1912_LTSR_CU4.iso
    log                 ${output}

*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}