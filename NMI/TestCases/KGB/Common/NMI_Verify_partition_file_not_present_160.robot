*** Settings ***
Library            SSHLibrary
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Resource           ../../../Resources/resource.txt
 

*** Variables ***
 
*** Test Cases ***
Checking if partition_creation_done file not present
    [Tags]                      Partition flag
    Set Client Configuration    timeout=25 seconds        prompt=#:
    ${output}=                  Execute Command           ls /var/ | grep partition_creation_done
    Should Not Contain          ${output}                 partition_creation_done
