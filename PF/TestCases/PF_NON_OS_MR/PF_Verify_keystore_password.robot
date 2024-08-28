*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Teardown    Close All Connections



*** Test Cases ***
Verify the FLS user is valid
    Open connection as root user
    ${keystore_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u keystore | cut -d ':' -f2 | cut -d ' ' -f2
    ${grep_keystore_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i keyStorePassValue= | cut -d "=" -f 2-
     ${repo_package}    Execute Command    ls /eniq/sw/platform | grep -i repository 
    ${script}    Execute Command    ls /eniq/sw/platform/${repo_package}/bin/ | grep -i EncryptDecryptUtility.sh
    ${activating}    Execute Command    su - dcuser -c "chmod u+x /eniq/sw/platform/${repo_package}/bin/${script}"
    ${pwd}    Execute Command    su - dcuser -c "/eniq/sw/platform/${repo_package}/bin/EncryptDecryptUtility.sh -d ${grep_keystore_pwd}" 
    Should Be Equal    ${keystore_pwd}    ${pwd} 