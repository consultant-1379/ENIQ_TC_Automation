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
    ${getting_latest_release_value}    Execute Command    ls /net/10.45.192.153/JUMP/|grep -i -o 'ENIQ_S[0-9][0-9].[0-9]'| tail -1
    Log To Console    ${getting_latest_release_value}
    ${license_count_from_mws_path}    Execute Command    cat /net/10.45.192.153/JUMP/${getting_latest_release_value} | grep -iE -o '\\"CXC[0-9]{7}\\"' | wc -l
    Log To Console    ${license_count_from_mws_path}
    Write    /eniq/sw/bin/licmgr -getlicinfo | grep -o -iE 'CXC[0-9]{7}' | wc -l
    ${license_count_installed_01}=    Read Until Prompt    strip_prompt=True
    ${license_count_installed}    Should Match Regexp    ${license_count_installed_01}    \\b[0-9]+\\b
    Log To Console    ${license_count_installed}
    Should Be Equal    ${license_count_from_mws_path}    ${license_count_installed}