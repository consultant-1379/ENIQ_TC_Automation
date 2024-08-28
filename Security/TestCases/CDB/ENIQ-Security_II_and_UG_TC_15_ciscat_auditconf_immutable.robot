*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test rule file is present for audit conf immutable
    ${result}=          Execute Command         find /etc/audit/rules.d/99-finalize.rules
    Should Be Equal     ${result}               /etc/audit/rules.d/99-finalize.rules

Test rule is present in audit rules file
    ${result}=          Execute Command         cat /etc/audit/audit.rules | tail -1
    Should Be Equal     ${result}               -e 2
    