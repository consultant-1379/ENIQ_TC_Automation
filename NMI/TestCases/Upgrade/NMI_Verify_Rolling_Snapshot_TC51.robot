*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt
 
*** Variables ***

*** Test Cases ***
Checking if Rolling Snapshot service is active
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl show -p ActiveState eniq-roll-snap.service | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
