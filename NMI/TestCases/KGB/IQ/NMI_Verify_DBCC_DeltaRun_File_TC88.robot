*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Variables ***

*** Test Cases ***

Checking whether DBCC Indicator file is deleted after delta run completion
    [Tags]                      DBCC Indicator
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls /eniq/admin/etc/ | grep ".dbcc_progress_indicator"
    Should Not Contain          ${output}               .dbcc_progress_indicator
