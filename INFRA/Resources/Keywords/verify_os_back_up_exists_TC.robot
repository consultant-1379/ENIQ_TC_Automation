*** settings ***
Library    SSHLibrary

*** Keywords ***
check_os_back_up_directory
    ${output}=    Execute Command   ls /JUMP|grep "OS_BACK_UP"
    [Return]     ${output}
