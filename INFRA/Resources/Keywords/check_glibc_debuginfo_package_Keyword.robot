*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_glibc_debuginfo_package
    ${output}=    Execute Command    rpm -qa|grep -i glibc-debuginfo
    [Return]     ${output}

