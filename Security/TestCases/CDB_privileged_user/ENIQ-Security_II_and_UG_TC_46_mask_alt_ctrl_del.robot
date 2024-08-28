*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            SSHLibrary  10 seconds
Library            String
*** Test Cases ***

Test wheather Ctrl+Alt+Del key to reboot is disabled or not
    ${data}=            Execute Command    sudo systemctl status ctrl-alt-del.target | grep Loaded: |cut -d':' -f2|cut -d' ' -f2
    Should Be Equal     ${data}            masked