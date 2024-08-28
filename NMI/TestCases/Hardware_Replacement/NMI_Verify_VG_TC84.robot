*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Validating VG state after replacement
    [Tags]                      Replacement
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         vgs vg_root -o attr --noheading
    Should Contain              ${output}               wz--n-
