*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check for perl-data-dumper
    ${output}=    Execute Command    rpm -qa|grep perl-Data-Dumper
    Should Not Be Empty     ${output}

