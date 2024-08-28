*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Verify alarm credential encrypted in database
    ${check_encdecryptscript}=    Execute Command    ls -Art /eniq/sw/platform/repository-*/bin/EncryptDecryptUtility.sh
    Set Suite Variable    ${check_encdecryptscript}
    IF    "${check_encdecryptscript}" != "${EMPTY}"
        ${change_script_perm}    Execute Command    su - dcuser -c "chmod u+x ${check_encdecryptscript}"
        ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bETLREPPassword=\\K[^ ]+" | head -1
        Should Not Be Empty    ${getencrypt_pwd}
        ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
        Should Not Be Empty    ${decrypt_password}
        ${check_dbconnection}=    Execute Command    su - dcuser -c 'echo -e "select TOP 1 ACTION_CONTENTS_01 from META_TRANSFER_ACTIONS where Transfer_Action_Name like '\\''alarmhandler%'\\''\\ngo\\n" | isql -P ${decrypt_password} -U etlrep -S repdb -b'
        Should Contain    ${check_dbconnection}    EncryptionFlag=YY
        Set Suite Variable    ${check_dbconnection} 
    ELSE
        Fail    EncryptDecryptUtility script not available
    END

Verify alarm credential decryption with encryptdecrypt script
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    ${getalarmencrypt_pwd}=    Execute Command    echo "${check_dbconnection}" | grep '^password=' | cut -d '=' -f 2-
    Should Not Be Empty    ${getalarmencrypt_pwd}
    Set Log Level    NONE
    ${decrypt_alarmdbcred}=    Execute Command    su - dcuser -c '${check_encdecryptscript} -d "${getalarmencrypt_pwd}"'
    Set log level    INFO    
    Should Not Be Empty    ${decrypt_alarmdbcred}

    