*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_kernel_debuginfo_package
    ${output}=    Execute Command    rpm -qa|grep -i kernel-debug-debuginfo
    [Return]     ${output}

