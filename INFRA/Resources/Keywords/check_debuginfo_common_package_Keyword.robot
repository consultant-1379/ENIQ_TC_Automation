*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_debuginfo_common_package
    ${output}=    Execute Command    rpm -qa|grep -i kernel-debuginfo-common
    [Return]     ${output}

