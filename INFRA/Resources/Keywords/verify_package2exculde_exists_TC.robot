*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_package2exclude_exists
    ${output}=    Execute Command    ls /JUMP/OM_LINUX_MEDIA/OM_LINUX_022_4/22.4.4/om_linux/omtools/ |grep packages2exclude
    [Return]    ${output}

