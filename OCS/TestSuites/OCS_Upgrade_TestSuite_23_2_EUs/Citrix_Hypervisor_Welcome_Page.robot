*** Settings ***
Documentation    Test case to verify if the customized message configured on 
...              the Citrix Hypervisor welcome page (/opt/xensource/www/index.html)
Library    SSHLibrary
Test Setup    Open Connection    ${HypervisorFQHN}
Test Teardown    Close Connection


*** Variables ***
${HypervisorFQHN}
${HypervisorPassword}


*** Test Cases ***
Citrix Hypervisor Welcome Page
    Login to Citrix Hypervisor
    ${output}=          Execute Command     cat /opt/xensource/www/index.html
    Should Contain      ${output}           <h2> The resource you are looking for cannot be displayed.</h2>
    log                 ${output}


*** Keywords ***
Login to Citrix Hypervisor
    Login    root    ${HypervisorPassword}