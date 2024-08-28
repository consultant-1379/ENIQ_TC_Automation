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
Test Teardown    Close All Connections
 
*** Variables ***
${host_name}    ${server}.athtem.eei.ericsson.se
${port_number}    2251  
${user_name}    dcuser  
${password}    Dcuser%12
@{user_list}    rjiokl    rjio65    
${server}    atvts4118

 
*** Test Cases ***
TC_61 Verify the changing of password of any user is not getting affected for other users where the username starting with same words for created new user via CLI
    Open connection    ${host_name}    port=${port_number}  
    Login    ${user_name}    ${password}
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:     timeout=100s
    FOR    ${users}    IN    @{user_list}
        ${get_users}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep "\\b${users}\\b"
        ${check_users_status}    Run Keyword And Return Status    Should Not Be Empty    ${get_users}
        IF    "${check_users_status}"=="False"
            ${new_pass}    Changing the password for adminui user
            Write    echo -e "${users}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
            ${out}    Read Until Prompt    strip_prompt=True
            Should Contain    ${out}    New User ${users} created successfully   
        END
    END
    
    
    ${tomcat_users_before}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
    ${tomcat_users_list_before}    Split String    ${tomcat_users_before}
    Sort List    ${tomcat_users_list_before}
    FOR    ${user_same}    IN    @{user_list}
        ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user_same}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
        ${pwd_same}    Execute Command   bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
        ${new_password}    Changing the password for adminui user
        Write    echo -e "${user_same}\\n${pwd_same}\\n${new_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out2}    Read Until Prompt    strip_prompt=True
        Should Contain     ${out2}    Password updated successfully
        ${tomcat_users_after}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
        ${tomcat_users_list_after}    Split String    ${tomcat_users_after}
        Sort List    ${tomcat_users_list_after}
        Lists Should Be Equal    ${tomcat_users_list_before}    ${tomcat_users_list_after}
    
    END
   
***Keywords***
Changing the password for adminui user
   ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    RETURN    ${password}
