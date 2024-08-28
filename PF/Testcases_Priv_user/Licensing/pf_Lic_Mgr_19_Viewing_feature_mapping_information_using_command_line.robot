*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the count of installed license using command line
    Open connection as root user
    Set Client Configuration    prompt=ieatrcx    timeout=10s
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    ${faj_value}    Set Variable    FAJ8010774
    ${cxc_value}    Set Variable    CXC4012419
    Write    /eniq/sw/bin/licmgr -map faj ${cxc_value}
    ${mapping}=    Read Until Prompt    strip_prompt=True
    Log To Console    ${mapping}
    Should Contain    ${mapping}    ${faj_value}