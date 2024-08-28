*** Settings ***
Documentation       Testing AdminUI web

Library             RPA.Browser.Selenium
Library             DateTime
Library             String
Library             SSHLibrary
Library             Collections
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/AdminUIWebUI.robot

Test Setup          Create connection
Test Teardown       Close All Connections


*** Variables ***
${SERVER}           atvts4118
${host_name}        ${server}.athtem.eei.ericsson.se
${port_number}      2251
${user_name}        dcuser
${password}         Dcuser%12
${url1}             https://${SERVER}.athtem.eei.ericsson.se:8443/adminui/servlet/LoaderStatusServlet


*** Test Cases ***
TC_60 Verify the changing of password of any user is not getting affected for other users where the username starting with same words for default user via Adminui
    
    ${ran_username}    ${ran_password}    Generate Random Password
    ${temp_username}    ${ran_password1}    Generate Random Password
    Write    echo -e "eniq${ran_username}\\n${ran_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    Should Contain    ${out}    New User eniq${ran_username} created successfully
    ${tomcat_users_before}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1 | sort --unique
    ${tomcat_users_before}    Split String    ${tomcat_users_before}

    ${encryp_pass}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="eniq".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
    ${pwd_same}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
    
    Open Available Browser    https://${Host_name}:8443/adminui/    options=set_capability("acceptInsecureCerts", True)             
    Wait Until Page Contains Element    //*[@id="username"]    timeout=100s     
    Input Text     //*[@id="username"]    eniq
    Input Password     //*[@id="password"]    ${pwd_same}  
    Click Button     //*[@id="submit"]
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
    Click on scroll down button
    Click on link    Change Password
    Input Password     //*[@id="op"]    ${pwd_same}
    Input Password     //*[@id="np"]    ${ran_password1}
    Input Password     //*[@id="cnp"]   ${ran_password1}
    Select Show Password
    Click On Submit Button
    Capture Page Screenshot    embed=True
    Validate the update message    Password updated successfully

    ${tomcat_users_after}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1 | sort --unique
    ${tomcat_users_after}    Split String    ${tomcat_users_after}
    ${length_before}    Get Length    ${tomcat_users_before}
    ${length_after}    Get Length    ${tomcat_users_after}
    IF    '${length_after}' == '${length_before}'
        Log    Nothing changed, All is working fine.
    ELSE
        Fail    Some values got overridden.
    END


*** Keywords ***
Create connection
    Open connection    ${host_name}    port=${port_number}
    Login    ${user_name}    ${password}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=100s

Generate Random Password
    ${ran_username}    Generate Random String    5    [NUMBERS]
    ${ran_password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    RETURN    ${ran_username}    ${ran_password}

closing all connection
    Logout from Adminui
    Close All Browsers
