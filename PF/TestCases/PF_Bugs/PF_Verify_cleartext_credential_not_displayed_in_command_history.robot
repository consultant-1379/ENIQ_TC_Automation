*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections

*** Test Cases ***
Verify dcuser credential encrypted in dcuser_password_file
    ${check_encdecryptscript}=    Execute Command    ls -Art /eniq/sw/platform/repository-*/bin/EncryptDecryptUtility.sh
    Set Suite Variable    ${check_encdecryptscript}
    IF    "${check_encdecryptscript}" != "${EMPTY}"
        ${change_script_perm}    Execute Command    su - dcuser -c "chmod u+x ${check_encdecryptscript}"
        ${checkdcuser_pwdfile}=    Execute Command    ls -Art /eniq/sw/conf/dcuser_password_file
        Should Not Be Empty    ${checkdcuser_pwdfile}
        ${dcuserencrypt_pwd}=    Execute Command    cat ${checkdcuser_pwdfile}
        Should Not Be Empty    ${dcuserencrypt_pwd}
        Set Suite variable    ${dcuserencrypt_pwd}  
        Set log Level    NONE  
        ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${dcuserencrypt_pwd}"'
        Should Not Be Empty    ${decrypt_password}
        Set Suite Variable     ${decrypt_password}
        Set log Level    INFO
    ELSE
        Fail    EncryptDecryptUtility script not available
    END

Verify cleartext credential not displayed in server history
    Skip If    "${PREV TEST STATUS}"=="FAIL"
    Set Client Configuration    prompt=REGEXP:${SERVER}\\[[^\\]]+\\]\\s\\{dcuser\\}\\s#:
    Write    su - dcuser
    ${cmd_output}=    Read Until Prompt    strip_prompt=True
    Set Log Level    NONE
    Write    ${check_encdecryptscript} -d "${dcuserencrypt_pwd}"
    ${cmd_output}=    Read Until Prompt    strip_prompt=True    loglevel=None
    Set Log Level    INFO
    Should Contain    ${cmd_output}    ${decrypt_password}
    Write    history | tail -2
    ${history_output}=    Read Until Prompt    strip_prompt=True    
    Log    ${history_output}
    Should Not Contain    ${history_output}    ${decrypt_password}
