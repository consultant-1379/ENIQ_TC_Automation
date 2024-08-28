*** Settings ***
Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            SSHLibrary  10 seconds
Library            OperatingSystem
Library            String
Library            ../Scripts/eniq_scurity_core.py
Variables          ../Scripts/eniq_scurity_core.py
*** Test Cases ***
Test wheather checking password aging and warning
    ${result}=    Execute Command    sudo chage -l "root" | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2 && chage -l "dcuser" | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2 && chage -l "storadm" | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2
    ${get_lines_mat}=        Get Lines Matching Regexp    ${result}       60
    Should Not Be Equal      ${result}    60
