*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
Library            Collections

*** Test Cases ***
Checking existence of storobs user
    ${result}=                       Execute Command          sudo getent passwd storobs | cut -d ':' -f 1
    Should Not Be Equal              ${result}                storobs

Checking storobs user is present in sugroup
    ${result}=                       Execute Command          sudo groups storobs | cut -d ' ' -f 4
    Should Not Be Equal              ${result}                sugroup