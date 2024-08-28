*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
check for perl-data-dumper
    ${output}=    Execute Command    rpm -qa|grep perl-Data-Dumper
    Should Not Be Empty     ${output}

