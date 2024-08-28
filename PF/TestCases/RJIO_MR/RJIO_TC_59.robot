*** Settings ***
#Documentation       Testing AdminUI web

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
Verify the changing of password of any user is not getting affected for other users where the username starting with same words for default user via CLI 
    
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
    Write
    ...    echo -e "eniq\\n${pwd_same}\\n${ran_password1}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
    ${out2}    Read Until Prompt    strip_prompt=True
    Should Contain     ${out2}    Password updated successfully

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
