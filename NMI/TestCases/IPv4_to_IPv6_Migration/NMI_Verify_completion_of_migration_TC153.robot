*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Checking the completion of migration
        [Tags]                      Cleanup                         
        Set Client Configuration    timeout=25 seconds                  prompt=#:
        ${output}=                  Execute Command                     cat /eniq/local_logs/ipv6_migration/premigration/${HNAME}_ipv6_migration.log | grep "Successfully completed the cleanup"
	Should Contain              ${output}                           Successfully completed the cleanup
