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
Test Teardown    Close All Connections
 
*** Variables ***
${host_name}    ${server}.athtem.eei.ericsson.se
${port_number}    2251  
${user_name}    dcuser  
${password}    Dcuser%12
@{user_list}    rjio1    rjio2
${server}    atvts4118
${url1}    https://atvts4118.athtem.eei.ericsson.se:8443/adminui/servlet/LoaderStatusServlet
 
*** Test Cases ***
TC_60 Verify the changing of password of any user is not getting affected for other users where the username starting with same words for default user via Adminui
    Open connection    ${host_name}    port=${port_number}  
    Login    ${user_name}    ${password}
    ${new_password}=    Changing the password for adminui
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:     timeout=100s
    # ${users}    Run Keyword And Return Status    Should Contain    ${tomcat_users_list_before}    ${user_same}
    FOR    ${users}    IN    @{user_list}
        ${get_users}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep "\\b${users}\\b"
        ${check_users_status}    Run Keyword And Return Status    Should Not Be Empty    ${get_users}
        IF    "${check_users_status}"=="False"
            ${new_pass}    Changing the password for adminui
            Write    echo -e "${users}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
            ${out}    Read Until Prompt    strip_prompt=True
            Should Contain    ${out}    New User ${users} created successfully   
        END
    END
    
    # ${tomcat_users_count_before}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | wc -l
    ${tomcat_users_before}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
    ${tomcat_users_list_before}    Split String    ${tomcat_users_before}
    Sort List    ${tomcat_users_list_before}
    ${user_same}    Get From List    ${user_list}    0
    ${encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user_same}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
    ${pwd_same}    Execute Command   bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
    ${new_password}    Changing the password for adminui
    Open Available Browser    ${url1}    options=set_capability("acceptInsecureCerts", True)      
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@id="username"]    timeout=100s 
    Input Text     //*[@id="username"]    ${user_same}
    Input Password     //*[@id="password"]    ${pwd_same}
    Click Button     //*[@id="submit"]
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
    Click on scroll down button
    Click on link    Change Password
    Input Password     //*[@id="op"]    ${pwd_same}
    Input Password     //*[@id="np"]    ${new_password}
    Input Password     //*[@id="cnp"]   ${new_password}
    Select Show Password
    Click On Submit Button
    Validate the update message    ${paswordChangeMsg}
    Sleep     100s
    # ${tomcat_users_count_after}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | wc -l
    # Should Be Empty    ${tomcat_users_count_before}    ${tomcat_users_count_after}
    ${tomcat_users_after}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
    ${tomcat_users_list_after}    Split String    ${tomcat_users_after}
    Sort List    ${tomcat_users_list_after}
    Lists Should Be Equal    ${tomcat_users_list_before}    ${tomcat_users_list_after}

        
         
   
***Keywords***
Changing the password for adminui
   ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    RETURN    ${password}


closing all connection
    Logout from Adminui
    Close All Browsers