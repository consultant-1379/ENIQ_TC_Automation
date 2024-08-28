*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical enmcertificate file is present in the ENIQ-S once the user selects from FLS mechanism
    Set Client Configuration    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#
    Write    sudo su - dcuser
    Read Until Prompt    strip_prompt=True
    Write     fls status
    ${fls_status}    Read Until Prompt    strip_prompt=True
    # ${fls_status}=    Execute Command  /eniq/sw/bin/fls status
    # Log    ${fls_status}
    ${check_fls_status}=    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    IF    ${check_fls_status} == True
        ${fls_enmcert_file}=    Execute Command    ls /eniq/home/dcuser | grep -i enmcertificate
        Log    ${fls_enmcert_file}
        ${check_enmcertificate_file}=    Run Keyword And Return Status    Verify file is present    ${fls_enmcert_file}
        IF    ${check_enmcertificate_file} == True
            Pass Execution    Enmcertificate is present
        ELSE
            ${create_enmcert_file}=    Execute Command    mkdir /eniq/home/dcuser/enmcertificate
            ${fls_enmcert_file}=    Execute Command    ls /eniq/home/dcuser | grep -i enmcertificate
            Log    ${fls_enmcert_file}
            Verify file is present    ${fls_enmcert_file} 
        END    
    ELSE
        Skip    Fls is not running 
    END

