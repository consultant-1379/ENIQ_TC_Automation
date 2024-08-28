*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Verifying passwords in ETLCserver.properties and createMetadata.properties 
    ${repo_package}=    Execute Command    ls /eniq/sw/platform/ | grep -i "repository-"    
    ${check_password_in_etlc}    ${stderr}=    Execute Command    cat /eniq/sw/platform/${repo_package}/conf/ETLCserver.properties | grep -i "password"    return_stderr=True
    ${check_password_in_meta}    ${stderr}=    Execute Command    cat /eniq/sw/platform/${repo_package}/conf/createMetadata.properties | grep -i "password"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Be Empty    ${check_password_in_etlc}
    Should Be Empty    ${check_password_in_meta}