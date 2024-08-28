*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_paramiko_package
    ${output}=    Execute Command    rpm -qa|grep paramiko
    [Return]     ${output}

