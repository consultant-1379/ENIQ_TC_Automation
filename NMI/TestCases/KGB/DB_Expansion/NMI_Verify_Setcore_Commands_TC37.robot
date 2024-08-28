*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn    
Library            String
Resource           ../../Resources/resource.txt

*** Variables ***
   
*** Test Cases ***

Verifying set_core_memcache command - Setting TempCache value present.
    [Tags]                      Verify setcore commands
    Set Client Configuration    timeout=25 seconds      prompt=#:  
    ${output}=                   Execute Command             bash /eniq/installation/core_install/bin/set_core_memcache.bsh -h -m -f -d /eniq/installation/config
    Set Global Variable            ${output}
    ${Line}=                    Get Line                ${output}                0
    Should Contain                 ${Line}      Setting TempCache value

Verifying set_core_memcache command - Setting MainCache value present.
    [Tags]             Verify setcore commands
    ${Line}=                    Get Line                ${output}                1
    Should Contain     ${Line}      Setting MainCache value
    
Verifying set_core_memcache command - Setting LargeMemory value present.
    [Tags]             Verify setcore commands
    ${Line}=                    Get Line                ${output}                2
    Should Contain     ${Line}      Setting LargeMemory value
    

Verifying set_core_memcache command - Setting CatalogCache value present.
    [Tags]             Verify setcore commands
    ${Line}=                    Get Line                ${output}                3
    Should Contain     ${Line}      Setting CatalogCache value
