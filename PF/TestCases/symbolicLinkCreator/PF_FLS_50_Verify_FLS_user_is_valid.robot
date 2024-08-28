*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Teardown    Close All Connections

*** Variables ***
@{server_details}


*** Test Cases ***
Verify the FLS user is valid
    Open connection as root user
    ${output}    Execute Command    cat /eniq/sw/conf/enmserverdetail
    ${server_details}    Split To Lines    ${output}
    Log To Console    ${server_details}
    FOR    ${element}    IN    @{server_details}
        ${host_details}    Split String    ${element}   
        ${repo_package}    Execute Command    ls /eniq/sw/platform | grep -i repository 
        ${script}    Execute Command    ls /eniq/sw/platform/${repo_package}/bin/ | grep -i EncryptDecryptUtility.sh
        ${activating}    Execute Command    su - dcuser -c "chmod u+x /eniq/sw/platform/${repo_package}/bin/${script}"
        ${pwd}    Execute Command    su - dcuser -c "/eniq/sw/platform/${repo_package}/bin/EncryptDecryptUtility.sh -d ${host_details}[4]"   
        ${Verify_msg}    Execute Command    su - dcuser -c "curl -k -L -c cookie.txt -X POST 'https://${host_details}[1]/login' -d IDToken1=${host_details}[3] -d IDToken2=${pwd}"
        Should Contain Any    ${Verify_msg}    Authentication Successful    login
        
        
    END