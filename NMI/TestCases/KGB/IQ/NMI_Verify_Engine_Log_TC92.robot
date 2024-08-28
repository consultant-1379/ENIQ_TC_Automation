*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../Resources/resource.txt

*** Test Cases ***
Checking whether errors and exceptions are checked in Engine log or not
    [Tags]                      Engine
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls /eniq/log/sw_log/engine/ | grep "engine-2" | tail -n 1
    Should Contain              ${output}               engine-2
    ${output}=                  Execute Command         cat /eniq/log/sw_log/engine/${output} | grep -iv "WARNING etlengine." | grep -iv "WARNINGTHRESHOLD" | grep -iv "WARNINGSYSTEM"
    Should Not Contain          ${output}               WARNING
