*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the migration logfile
        [Tags]                      Migration                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     cat /eniq/local_logs/ipv6_migration/${HNAME}_ipv6_migration.log | grep "ENIQ IPV6 Migration Stages Completed: 8 of 8"
	Should Contain              ${output}                           ENIQ IPV6 Migration Stages Completed: 8 of 8
