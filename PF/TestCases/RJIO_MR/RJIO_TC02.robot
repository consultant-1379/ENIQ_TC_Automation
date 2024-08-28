*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    DateTime
Library    String
Library    SSHLibrary
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
# Test Setup    Connect to server as a dcuser
# Test Teardown    Close All Connections

*** Variables ***
${SERVER}    atvts4150
${Host_name}    ${SERVER}.athtem.eei.ericsson.se
${port_number}    2251  
${user_name}    dcuser  
${password}    Dcuser%12


*** Test Cases ***

Verify login failure details in adminuistatus.log when adminui user password is expired
    Create connection
    ${users}    Execute Command     cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
    ${users}    Split String    ${users}
    ${expired_users}    Create List
    FOR    ${user}    IN    @{users}
        Write    echo -e "${user}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A PASSWORD_EXPIRY
        ${out2}    Read Until Prompt    strip_prompt=True
        IF    'already expired' in '''${out2}'''
            Append To List    ${expired_users}    ${user}
        END
    END
    ${length}    Get Length    ${expired_users}
    IF    not ${length} == 0
        FOR    ${user}    IN    @{expired_users}
            ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${decr_pwd}    Execute Command   bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            Open Available Browser    https://${Host_name}:8443/adminui/    options=set_capability("acceptInsecureCerts", True)             
            Wait Until Page Contains Element    //*[@id="username"]    timeout=100s     
            Input Text     //*[@id="username"]    ${user}
            Input Password     //*[@id="password"]    ${decr_pwd}
            Click Button     //*[@id="submit"]
            Capture Page Screenshot    embed=True
            Close Browser
        END
    ELSE
        Log    No users password is expired. Passing the test-case
    END

*** Keywords ***
Create connection
    Open Connection
    ...    ${SERVER}.athtem.eei.ericsson.se
    ...    port=2251
    ...    timeout=100s
    ...    prompt=eniqs[eniq_stats] {dcuser} #:
    Login    dcuser    Dcuser%12