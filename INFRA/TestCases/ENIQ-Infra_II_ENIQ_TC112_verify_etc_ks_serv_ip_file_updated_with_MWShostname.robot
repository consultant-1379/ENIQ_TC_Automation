
*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
Verify if /etc/.ks_serv_ip file is updated with MWS hostname

    ${MWS_hostname}=    Execute Command     cat /eniq/installation/config/INSTALL_SERVER
    ${output}=    Execute Command     cat /etc/.ks_serv_ip | grep ${MWS_hostname}
    Should Not Be Empty    ${output}
