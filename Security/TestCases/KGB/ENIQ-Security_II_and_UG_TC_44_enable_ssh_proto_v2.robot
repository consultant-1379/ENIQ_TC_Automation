*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test wheather profile is present or not
    ${data}=            Execute Command              find /etc/ssh/ssh_config
    ${proto}=           Get Lines Matching Regexp    ${data}      /etc/ssh/ssh_config
    Should Be Equal     ${proto}                     /etc/ssh/ssh_config
Test wheather ssh proto v2 is enable or not
    ${data}=            Execute Command              cat /etc/ssh/ssh_config | grep Protocol
    ${proto}=           Get Lines Matching Regexp    ${data}      Protocol 2
    Should Be Equal     ${proto}                     Protocol 2