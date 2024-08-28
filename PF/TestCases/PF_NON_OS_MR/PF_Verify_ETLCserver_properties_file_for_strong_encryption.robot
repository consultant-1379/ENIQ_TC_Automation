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
Verify ETLCserver.properties file for strong encryption 
    Open connection as root user
    ${grep_niq_file_pwd}=    Execute Command   cat /eniq/sw/conf/niq.ini | grep -i "ETLREPPassword=" | cut -d "=" -f 2-
    ${grep_ETLCserver_encryption_pwd}=    Execute Command    cat /eniq/sw/conf/ETLCServer.properties | grep -i "Encryption_Flag = YY"
    Should Not Be Empty    ${grep_ETLCserver_encryption_pwd}   
    ${grep_ETLCserver_pwd}=    Execute Command    cat /eniq/sw/conf/ETLCServer.properties | grep -i "ENGINE_DB_PASSWORD = "|cut -d "=" -f 2- | cut -d " " -f2
     ${repo_package}    Execute Command    ls /eniq/sw/platform | grep -i repository 
    ${script}    Execute Command    ls /eniq/sw/platform/${repo_package}/bin/ | grep -i EncryptDecryptUtility.sh
    ${activating}    Execute Command    su - dcuser -c "chmod u+x /eniq/sw/platform/${repo_package}/bin/${script}"
    ${ETLCserver_pwd}    Execute Command    su - dcuser -c "/eniq/sw/platform/${repo_package}/bin/EncryptDecryptUtility.sh -d ${grep_ETLCserver_pwd}"
    ${niq_file_pwd}    Execute Command    su - dcuser -c "/eniq/sw/platform/${repo_package}/bin/EncryptDecryptUtility.sh -d ${grep_niq_file_pwd}"  
    Should Be Equal    ${ETLCserver_pwd}    ${niq_file_pwd} 