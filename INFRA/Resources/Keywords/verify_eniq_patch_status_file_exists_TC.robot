*** settings ***
Library    SSHLibrary

*** Keywords ***
check_eniq_patch_status_file
    ${output}=    Execute Command    ls /eniq/ericsson/config/ | grep eniq_patch_status_file
    [Return]     ${output}

