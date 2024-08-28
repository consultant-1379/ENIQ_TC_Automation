*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***
Verify physical enmcertificate file is present in the ENIQ-S once the user selects from FLS mechanism
    ${fls_status}=    Execute Command  /eniq/sw/bin/fls status
    Log    ${fls_status}
    ${check_fls_status}=    Run Keyword And Return Status    Should Contain    ${fls_status}    FLS is running
    IF    ${check_fls_status} == True
        ${fls_enmcert_file}=    Execute Command    ls /eniq/home/dcuser | grep -i enmcertificate
        Log    ${fls_enmcert_file}
        ${check_enmcertificate_file}=    Run Keyword And Return Status    Verify file is present    ${fls_enmcert_file}
        IF    ${check_enmcertificate_file} == True
            Pass Execution    Enmcertificate file is present
        ELSE
            ${create_enmcert_file}=    Execute Command    touch /eniq/home/dcuser/enmcertificate
            ${fls_enmcert_file}=    Execute Command    ls /eniq/home/dcuser | grep -i enmcertificate
            Log    ${fls_enmcert_file}
            Verify file is present    ${fls_enmcert_file} 
        END    
    ELSE
        Skip    Fls is not running 
    END

