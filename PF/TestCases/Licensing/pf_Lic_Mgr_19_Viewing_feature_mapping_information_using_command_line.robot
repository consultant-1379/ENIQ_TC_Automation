*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
Verify the count of installed license using command line
    Connect to server as a dcuser
    ${faj_value}    Set Variable    FAJ8010774
    ${cxc_value}    Set Variable    CXC4012419
    ${mapping}    Execute Command    /eniq/sw/bin/licmgr -map faj ${cxc_value}
    Log To Console    ${mapping}
    Should Be Equal    ${mapping}    ${faj_value}