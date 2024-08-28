*** settings ***
Library    SSHLibrary

*** Keywords ***
verify_creation_kickstart_repo1 
    ${output1}=    Execute Command    ls /etc/yum.repos.d/|grep "ericINSTALLPATCH.repo"
    [Return]     ${output1}

