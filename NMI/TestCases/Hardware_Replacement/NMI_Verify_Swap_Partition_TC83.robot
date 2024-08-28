*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Validating swap partition
    [Tags]                      Replacement
    Set Client Configuration    timeout=25 seconds        prompt=#:
    ${output}=                  Execute Command           /usr/bin/cat /etc/fstab | grep swap | awk '{print $1}'
    Should Contain              ${output}                 /dev/mapper/eniq_stats_pool-swapvol
