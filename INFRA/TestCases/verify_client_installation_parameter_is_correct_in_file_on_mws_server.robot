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
check for client host details
    ${output}=    Execute Command    cat /JUMP/LIN_MEDIA/1/kickstart/${hostname}/${hostname}_installation_param_details
    Should Not Be Empty     ${output}


