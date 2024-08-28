*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_package2exclude_exists
    ${output}=    Execute Command    ls /JUMP/OM_LINUX_MEDIA/OM_LINUX_0${release}/${sprint}/om_linux/omtools/ |grep packages2exclude
    [Return]    ${output}

