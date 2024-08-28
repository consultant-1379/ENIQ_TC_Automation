*** settings ***
Library    SSHLibrary

*** Keywords ***
check_eniq_om_status_file
    ${output}=    Execute Command    ls /eniq/installation/config/ | grep eniq_om_status_file
    [Return]     ${output}



