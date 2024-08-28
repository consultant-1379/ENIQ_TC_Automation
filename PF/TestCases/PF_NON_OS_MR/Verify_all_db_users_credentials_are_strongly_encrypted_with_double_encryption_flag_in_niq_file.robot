*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Suite setup steps
Suite Teardown   Close All Connections

*** Test Cases ***
Verify encryptdecrpt script is present in server
    ${check_encdecryptscript}=    Execute Command    ls -Art /eniq/sw/platform/repository-*/bin/EncryptDecryptUtility.sh
    IF    "${check_encdecryptscript}" != "${EMPTY}"
        ${change_script_perm}    Execute Command    su - dcuser -c "chmod u+x ${check_encdecryptscript}"
        Set Suite Variable    ${check_encdecryptscript}
        Set Suite Variable    ${check_encdecryptscript_status}    True
    ELSE
        Set Suite Variable    ${check_encdecryptscript_status}    False
        Fail    EncryptDecryptUtility script not available
    END

Verify etlrep password encrypted status in niq file
    ${get_encrypt_status}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i "\\bETLREPPassword_Encrypted="
    Should Contain    ${get_encrypt_status}    YY

Verify etlrep password decryption and database connection
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Skip If    "${check_encdecryptscript_status}"=="False"
    ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bETLREPPassword=\\K[^ ]+" | head -1
    Should Not Be Empty    ${getencrypt_pwd}
    ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
    Should Not Be Empty    ${decrypt_password}
    ${check_dbconnection}=    Execute Command    su - dcuser -c"isql -P ${decrypt_password} -U etlrep -S repdb -b <<< 'exit' && echo 'True' || echo 'False'"
    Should Contain    ${check_dbconnection}    True

Verify dwhrep password encrypted status in niq file
    ${get_encrypt_status}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i "\\bDWHREPPassword_Encrypted="
    Should Contain    ${get_encrypt_status}    YY

Verify dwhrep password decryption and database connection
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Skip If    "${check_encdecryptscript_status}"=="False"
    ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bDWHREPPassword=\\K[^ ]+" | head -1
    Should Not Be Empty    ${getencrypt_pwd}
    ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
    Should Not Be Empty    ${decrypt_password}
    ${check_dbconnection}=    Execute Command    su - dcuser -c"isql -P ${decrypt_password} -U dwhrep -S repdb -b <<< 'exit' && echo 'True' || echo 'False'"
    Should Contain    ${check_dbconnection}    True

Verify dc password encrypted status in niq file
    ${get_encrypt_status}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i "\\bDCPassword_Encrypted="
    Should Contain    ${get_encrypt_status}    YY

Verify dc password decryption and database connection
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Skip If    "${check_encdecryptscript_status}"=="False"
    ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bDCPassword=\\K[^ ]+" | head -1
    Should Not Be Empty    ${getencrypt_pwd}
    ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
    Should Not Be Empty    ${decrypt_password}
    ${check_dbconnection}=    Execute Command    su - dcuser -c"isql -P ${decrypt_password} -U dc -S dwhdb -b <<< 'exit' && echo 'True' || echo 'False'"
    Should Contain    ${check_dbconnection}    True

Verify dcbo password encrypted status in niq file
    ${get_encrypt_status}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i "\\bDCBOPassword_Encrypted="
    Should Contain    ${get_encrypt_status}    YY

Verify dcbo password decryption and database connection
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Skip If    "${check_encdecryptscript_status}"=="False"
    ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bDCBOPassword=\\K[^ ]+" | head -1
    Should Not Be Empty    ${getencrypt_pwd}
    ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
    Should Not Be Empty    ${decrypt_password}
    ${check_dbconnection}=    Execute Command    su - dcuser -c"isql -P ${decrypt_password} -U dcbo -S dwhdb -b <<< 'exit' && echo 'True' || echo 'False'"
    Should Contain    ${check_dbconnection}    True

Verify dcpublic password encrypted status in niq file
    ${get_encrypt_status}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i "\\bDCPUBLICPassword_Encrypted="
    Should Contain    ${get_encrypt_status}    YY

Verify dcpublic password decryption and database connection
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Skip If    "${check_encdecryptscript_status}"=="False"
    ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bDCPUBLICPassword=\\K[^ ]+" | head -1
    Should Not Be Empty    ${getencrypt_pwd}
    ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
    Should Not Be Empty    ${decrypt_password}
    ${check_dbconnection}=    Execute Command    su - dcuser -c"isql -P ${decrypt_password} -U dcpublic -S dwhdb -b <<< 'exit' && echo 'True' || echo 'False'"
    Should Contain    ${check_dbconnection}    True

Verify dba password encrypted status in niq file
    ${get_encrypt_status}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -i "\\bDCPUBLICPassword_Encrypted="
    Should Contain    ${get_encrypt_status}    YY

Verify dba password decryption and database connection
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Skip If    "${check_encdecryptscript_status}"=="False"
    ${getencrypt_pwd}=    Execute Command    cat /eniq/sw/conf/niq.ini | grep -oP "\\bDBAPassword=\\K[^ ]+" | head -1
    Should Not Be Empty    ${getencrypt_pwd}
    ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${getencrypt_pwd}"'
    Should Not Be Empty    ${decrypt_password}
    ${check_dbconnection}=    Execute Command    su - dcuser -c"isql -P ${decrypt_password} -U dba -S dwhdb -b <<< 'exit' && echo 'True' || echo 'False'"
    Should Contain    ${check_dbconnection}    True


*** Keywords ***
Suite setup steps
    Open connection as root user