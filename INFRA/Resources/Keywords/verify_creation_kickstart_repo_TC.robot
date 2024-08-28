*** Settings ***
Library    SSHLibrary

*** Keywords ***
verify_creation_kickstart_repo
    ${output}=    Execute Command    ls /etc/yum.repos.d/|grep "temp_rhel_update.repo"
     [Return]     ${output}    

