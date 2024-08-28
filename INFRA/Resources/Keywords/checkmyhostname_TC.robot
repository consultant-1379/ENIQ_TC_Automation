*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_myhostname
    ${output}=    Execute Command    cat /etc/nsswitch.conf| grep hosts:
    [Return]     ${output}

