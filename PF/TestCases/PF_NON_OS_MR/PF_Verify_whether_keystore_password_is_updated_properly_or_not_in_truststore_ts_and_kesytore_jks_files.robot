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
    ${check_for_keystore_file}    Execute Command    ls /eniq/sw/runtime/tomcat/ssl/ | grep -i keystore.jks
    Should Not Be Empty    ${check_for_keystore_file}
    ${security_dir}=    Execute Command    /eniq/sw/runtime/jdk/bin/keytool -list -keystore /eniq/sw/runtime/tomcat/ssl/keystore.jks -storepass ${keystore_pwd}
    Should Not Contain    ${security_dir}    Keystore was tampered with, or password was incorrect
    ${check_for_truststore_file}    Execute Command    ls /eniq/sw/runtime/jdk/jre/lib/security/ | grep -i truststore.ts
    ${verify_truststore_file_is_present}    Run Keyword And Return Status    Should Not Be Empty    ${check_for_truststore_file}
    IF    ${verify_truststore_file_is_present} == False
         ${fls_status}=    Execute command    su - dcuser -c "/eniq/sw/bin/fls status| grep -i 'FLS is running'"
        Should Be Empty    ${fls_status}
        ${fls_status_1}=    Execute command    su - dcuser -c "/eniq/sw/bin/fls status| grep -i 'FLS is not enabled'"
        ${verify_fls_is_not_enabled}    Run Keyword And Return Status    Should Not Be Empty    ${fls_status_1}
        Skip If    ${verify_fls_is_not_enabled}==True
    ELSE
        ${security_dir}=    Execute Command    /eniq/sw/runtime/jdk/bin/keytool -list -keystore /eniq/sw/runtime/jdk/jre/lib/security/truststore.ts -storepass ${keystore_pwd}
        Should Not Contain    ${security_dir}    Keystore was tampered with, or password was incorrect
        
    END
