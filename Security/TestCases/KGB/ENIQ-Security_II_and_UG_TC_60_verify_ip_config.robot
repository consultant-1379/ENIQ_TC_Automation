*** Settings ***

Suite Setup        Open Connection and SSH Login
Suite Teardown     Close All Connections
Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String
Resource           ../../Resources/cTAF_resource.resource


*** Test Cases ***
check wheather IP address is congigured or not
    ${result}=    Execute Command    ip addr | grep 'state UP' -A2 | awk '{print $2}' | cut -f1  -d'/' | head -n 1 | cut -c 1
   	Should Be Lower Case    ${result}