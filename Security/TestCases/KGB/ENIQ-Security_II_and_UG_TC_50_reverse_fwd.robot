*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test reverse path forwarding is enforced with strict rpfilter
    ${result}=               Execute Command              cat /proc/sys/net/ipv4/conf/default/rp_filter
    Should Be Equal          ${result}                    1