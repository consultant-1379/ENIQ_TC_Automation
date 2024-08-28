*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Library     ../../Scripts/random_generating_password.py



*** Test Cases ***
Verify the Change the keystore password and check the four files and verify the passwords in Keystore passwords
    Connect to server as a dcuser
    ${random_password_generated}=    random_generating_complaint_passwords
    Log To Console    ${random_password_generated}
    ${Date}=    Get current date in yyyy.mm.dd result_format
    Log To Console    ${Date}
    Execute the Command    cp /eniq/sw/runtime/tomcat/conf/server.xml /eniq/sw/runtime/tomcat/conf/server.xml_backup_${Date}
    Execute the Command    su - ${root_user}
    Execute the Command   ${root_pwd}
    Execute the Command    /eniq/sw/installer/configure_newkeystore.sh
    Execute the Command    ${random_password_generated}
    ${pwd_success_msg}=    Execute the Command    ${random_password_generated}
    Sleep    150s
    Verify the msg    ${pwd_success_msg}    Service stopping eniq-webserver
    
    Execute the Command    ${dc_user}
    ${keystore_pwd}=    Execute Command    /eniq/sw/installer/getPassword.bsh -u keystore | cut -d ':' -f2 | cut -d ' ' -f2
    ${tomcat_keystore}=    Execute Command    cat /eniq/sw/runtime/tomcat/conf/server.xml | grep -i keystorePass= | cut -d "=" -f 2-
    ${tomcat_keystore_output}=    Get Regexp Matches    ${tomcat_keystore}    \\d+
    ${tomcat_pwd}=    Evaluate    ''.join(chr(int(code)) for code in ${tomcat_keystore_output})
    ${grep_keystore_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i keyStorePassValue= | cut -d "=" -f 2-
    ${decrpting_pwd}=   Execute Command    echo -e "${grep_keystore_pwd}" | base64 -d
    Should Be Equal    ${keystore_pwd}    ${decrpting_pwd}
    Should Be Equal    ${tomcat_pwd}    ${keystore_pwd}    
    ${security_dir}=    Execute Command    /eniq/sw/runtime/jdk/bin/keytool -list -keystore /eniq/sw/runtime/jdk/jre/lib/security/truststore.ts -storepass ${keystore_pwd}
    Verify the msg    ${security_dir}    Keystore type: JKS
    ${store_pass}=    Execute Command    /eniq/sw/runtime/jdk/bin/keytool -list -v -keystore /eniq/sw/runtime/tomcat/ssl/keystore.jks -storepass ${keystore_pwd}
    Verify the msg    ${store_pass}    Signature algorithm name

    #reverting back old_password
    Execute the Command    su - ${root_user}
    Execute the Command   ${root_pwd}
    Execute the Command    /eniq/sw/installer/configure_newkeystore.sh
    Execute the Command    ${random_password_generated}
    Execute the Command    EniqOnSSL
    ${pwd_success_msg_01}=    Execute the Command    EniqOnSSL
    Sleep    150s
    Verify the msg    ${pwd_success_msg_01}    Service stopping eniq-webserver
    [Teardown]    Test teardown

*** Keywords ***
Test teardown
    Close Connection

    

