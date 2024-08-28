*** Settings ***

Library    RPA.Browser.Selenium
Library    DateTime
Library    String
Library    SSHLibrary
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot

Suite Teardown    Suite teardown steps

*** Variables ***
${SERVER}    atvts4118
${host_123}    ${SERVER}.athtem.eei.ericsson.se


*** Test Cases ***

Verify changing password by giving expired password as existing password
    Create connection
    ${new_password}=    Changing the password for adminui 
    ${users}    Execute Command     cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
    ${users}    Split String    ${users}
    ${expired_users}    Create List
    FOR    ${user}    IN    @{users}
        Write    echo -e "${user}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A PASSWORD_EXPIRY
        ${out2}    Read Until Prompt    strip_prompt=True
        IF    'already expired' in '''${out2}'''
            Append To List    ${expired_users}    ${user}
            Log    ${expired_users}
        END
    END
    ${expiry_list}    Run Keyword And Return Status    Should Not Be Empty    ${expired_users}
    IF    "${expiry_list}"=="True"
        FOR    ${expired_user}    IN    @{expired_users}
            ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${expired_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${existing_pass}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            Write    echo -e "${expired_user}\\n${existing_pass}\\n${new_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
            ${out2}    Read Until Prompt    strip_prompt=True
            Should Contain     ${out2}    Password updated successfully
            ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${expired_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${decr_pwd}    Execute Command   bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            
            #Adminui login
            Open Available Browser    https://${host_123}:8443/adminui/    options=set_capability("acceptInsecureCerts", True)      
            Maximize Browser Window
            Wait Until Page Contains Element    //*[@id="username"]    timeout=100s 
            Input Text     //*[@id="username"]    ${expired_user}
            Input Password     //*[@id="password"]    ${decr_pwd}
            Click Button     //*[@id="submit"]
            
            ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
            Run Keyword If    ${IsElementVisible}    handle alert    accept
            RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
                
            Capture Page Screenshot    embed=True  
         END  
    ELSE
    Log    No expired users found        
    END
    [Teardown]    Logout from Adminui if logged in 
        
*** Keywords ***
Create connection
    Open Connection
    ...    ${SERVER}.athtem.eei.ericsson.se
    ...    port=2251
    ...    timeout=100s
    ...    prompt=eniqs[eniq_stats] {dcuser} #:
    Login    dcuser    Dcuser%12

Changing the password for adminui
   
    ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    RETURN    ${password}

Suite teardown steps
    Close All Connections
    Close All Browsers
    