*** settings ***
Library    SSHLibrary

*** Keywords ***
check_patch_status_file
    ${output}=    Execute Command    ls /var/tmp | grep patch_status_file
    [Return]     ${output}
