*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_for_patch_directory
    ${output}=    Execute Command    ls /var/ericsson/log/patch
    [Return]     ${output}



