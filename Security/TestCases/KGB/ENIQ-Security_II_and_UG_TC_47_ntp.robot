*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
Library            Collections

*** Test Cases ***
Checking ntp service
    ${result}=                       Execute Command          systemctl list-units --type=service --state=active | grep ntp
    Should Not Be Equal              ${result}                ntp.service
Checking ntp configuration file
    ${result}=                       Execute Command          find /etc/ntp.conf
    Should Not Be Equal              ${result}                /etc/ntp.conf