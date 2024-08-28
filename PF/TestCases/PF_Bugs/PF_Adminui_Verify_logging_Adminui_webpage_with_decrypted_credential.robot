*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup   Suite setup steps
Suite Teardown    Suite teardown steps   


*** Test Cases ***
Verify Adminui credential is encrypted
    ${check_tomcatuserfile}=    Execute Command    ls -Art /eniq/sw/runtime/tomcat/conf/tomcat-users.xml
    IF    "${check_tomcatuserfile}" != "${EMPTY}"
        Set Global Variable    ${check_tomcatuserfile}
        ${check_adminuipwd}=    Execute Command    cat ${check_tomcatuserfile} | grep -io '<user [^>]*username="${USERNAME}"[^>]*>'
        Should Contain    ${check_adminuipwd}    ENCRYPTION
    ELSE
        Fail    tomcat-user.xml file not available in server
    END

Verify decryption of Adminui credential
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    ${check_encdecryptscript}=    Execute Command    ls -Art /eniq/sw/platform/repository-*/bin/EncryptDecryptUtility.sh
    IF    "${check_encdecryptscript}" != "${EMPTY}"
        ${change_script_perm}    Execute Command    su - dcuser -c "chmod u+x ${check_encdecryptscript}"
        ${get_adminuipwd}=    Execute Command    cat ${check_tomcatuserfile} | grep -io '<user [^>]*username="${USERNAME}"[^>]*>' | grep -ioP '(?<=password="{ENCRYPTION})[^"]+'
        ${decrypt_password}    Execute Command     su - dcuser -c '${check_encdecryptscript} -d "${get_adminuipwd}"'
        Should Not Be Empty    ${decrypt_password}
        # Log To Console    ${decrypt_password}
        Set Global Variable    ${decrypt_password}
    ELSE
        Fail    EncryptDecrypt script not available
    END


Verify Adminui Login with decrypted credential
    Skip if    '${PREV TEST STATUS}'=='FAIL' or '${PREV TEST STATUS}'=='SKIP'
    Launch the AdminUI page in browser
    Login To Adminui with decrypt creds    ${USERNAME}    ${decrypt_password}
    [Teardown]    Logout from Adminui if logged in 


*** Keywords ***
Login To Adminui with decrypt creds
    [Arguments]    ${input_user_args}    ${input_passwd_args}
    AdminUIWebUI.Input Username    ${USERNAME}
    AdminUIWebUI.Input Pass    ${decrypt_password}
    Click On Submit Button
	Sleep    2s
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    Wait Until Page Contains Element    //button[text()='System Status']    timeout=40s


Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Open connection as root user
    Set webpage selenium speed

Suite teardown steps
    Close All Connections
    Close All Browsers