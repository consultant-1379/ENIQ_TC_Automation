*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_san_type_unity
    ${output}=    Execute Command    cat/eniq/installation/config/SunOS.ini|grep-w"SAN_DEVICE"|awk-F"="'{print$2}
    [Return]     ${output}
