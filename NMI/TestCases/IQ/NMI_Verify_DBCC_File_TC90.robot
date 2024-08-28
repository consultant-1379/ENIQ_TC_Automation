*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Checking whether DBCC Indicator file is deleted after full run completion
    [Tags]                      DBCC Indicator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls /eniq/admin/etc/ | grep "dbcc_full_run_indicator"
    Should Not Contain          ${output}               dbcc_full_run_indicator
