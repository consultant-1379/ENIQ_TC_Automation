*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the flag file after migration
        [Tags]                      flag file                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     ls -lart /eniq/sw/conf/ipv6_migrated
	Should Contain              ${output}                           /eniq/sw/conf/ipv6_migrated
