i*** settings ***
Library    SSHLibrary

*** Keywords ***
check_om_status_file
    ${output}=    Execute Command    ls /var/tmp | grep om_status_file
    [Return]     ${output}
~




