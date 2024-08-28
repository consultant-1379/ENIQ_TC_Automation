*** Settings ***
Library             String
Library             SSHLibrary
Resource            ../../Resources/Keywords/Cli.robot
Resource            ../../Resources/Keywords/Variables.robot
Resource            ../../Resources/Keywords/AdminUIWebUI.robot
Library             RPA.Browser.Selenium
Library             Collections

Test Setup         Create connection
Test Teardown      Close All Connections


*** Variables ***
${SERVER}       atvts4150
${host_123}     ${SERVER}.athtem.eei.ericsson.se
# ${port_for_vapp}    2251


*** Test Cases ***
PF TC 01 RJIO: Verify the password expiry section for displaying no. of days left for expiry of adminui user password under system status page
    Create Random user
    Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
    Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
    Input Text    //*[@id="username"]    ${new_user}
    Input Password    //*[@id="password"]    ${new_pass}
    Click Button    //*[@id="submit"]
    Wait Until Page Contains Element    //*[contains(text(),'Password will expire')]    timeout=100s
    ${pass_msg}    Get Text    //*[contains(text(),'Password will expire')]
    ${days}    Get Regexp Matches    ${pass_msg}    \\d+
    IF    ${days}[0] > 14
        ${color}    Get Element Attribute    (//img)[last()]    alt
        IF    '${color}'== 'Green'
            Log    Green Color is present
        ELSE
            Fail    ${color} is present
        END
    END
    IF    ${days}[0] < 7
        ${color}    Get Element Attribute    (//img)[last()]    alt
        IF    '${color}'== 'Red'
            Log    Red Color is present
        ELSE
            Fail    ${color} is present
        END
    END
    IF    7 < ${days}[0] < 14
        ${color}    Get Element Attribute    (//img)[last()]    alt
        IF    '${color}'== 'Yellow'
            Log    Yellow Color is present
        ELSE
            Fail    ${color} is present
        END
    END

PF TC 02 RJIO: Verify login failure details in adminuistatus.log when adminui user password is expired
    Create connection
    ${users}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
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
            ${encryp_pass}    Execute Command
            ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${decr_pwd}    Execute Command
            ...    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
            Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
            Input Text    //*[@id="username"]    ${user}
            Input Password    //*[@id="password"]    ${decr_pwd}
            Click Button    //*[@id="submit"]
            Capture Page Screenshot    embed=True
            Close Browser
        END
    ELSE
        Log    No users password is expired. Passing the test-case
    END

PF TC 03 RJIO: Verify changing password by giving expired password as existing password
    Create connection
    ${temp_user}    ${new_password}    Generate Random username and password
    ${users}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
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
            ${encryp_pass}    Execute Command
            ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${expired_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${existing_pass}    Execute Command
            ...    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            Write
            ...    echo -e "${expired_user}\\n${existing_pass}\\n${new_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
            ${out2}    Read Until Prompt    strip_prompt=True
            Should Contain    ${out2}    Password updated successfully
            ${encryp_pass}    Execute Command
            ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${expired_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${decr_pwd}    Execute Command
            ...    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}

            # Adminui login
            Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
            Maximize Browser Window
            Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
            Input Text    //*[@id="username"]    ${expired_user}
            Input Password    //*[@id="password"]    ${decr_pwd}
            Click Button    //*[@id="submit"]

            ${IsElementVisible}    Run Keyword And Return Status
            ...    alert should be present
            ...    Alert Text: Engine is set to NoLoads
            IF    ${IsElementVisible}    handle alert    accept
            RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
            Capture Page Screenshot    embed=True
        END
    ELSE
        Log    No expired users found
    END
    [Teardown]    Logout from Adminui if logged in

PF TC 04 RJIO: Verify the no. of days left for password to be expired using CLI
    Create connection

    ${users1}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
    ${users}    Split String    ${users1}
    ${expired_users}    Create List
    FOR    ${user}    IN    @{users}
        Write    echo -e "${user}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A PASSWORD_EXPIRY
        ${out2}    Read Until Prompt    strip_prompt=True
        IF    'already expired' in '''${out2}'''
            Append To List    ${expired_users}    ${user}
            Log    ${expired_users}
        END
    END

    ${expiry_list}    Run Keyword And Return Status    Should Be Empty    ${expired_users}
    IF    "${expiry_list}"=="False"
        Log    ${expired_users}
        Fail    "Above Username's Password has already expired"
    ELSE
        Log    No users password is expired. Passing the test-case
    END

PF TC 05 RJIO: Verify login failure details in adminuistatus.log when adminui user password is expired
    ${users}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="\\K[^"]+'
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
            ${encryp_pass}    Execute Command
            ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
            ${decr_pwd}    Execute Command
            ...    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
            Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
            Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
            Input Text    //*[@id="username"]    ${user}
            Input Password    //*[@id="password"]    ${decr_pwd}
            Click Button    //*[@id="submit"]
            ${IsElementVisible}    Run Keyword And Return Status
            ...    alert should be present
            ...    Alert Text: Engine is set to NoLoads
            IF    ${IsElementVisible}    handle alert    accept
            RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
            Capture Page Screenshot    embed=True
            Close Browser
        END
    ELSE
        Log    No users password is expired. Passing the test-case
    END

PF TC 29 RJIO: Verify change password by giving existing password
    ${ranuser}    Execute Command    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1 | shuf -n 1
    ${def_encryp_pass}    Execute Command    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${ranuser}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
    ${existing_pass}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${def_encryp_pass}
    Write    echo -e "${ranuser}\\n${existing_pass}\\n${existing_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
    ${out2}    Read Until Prompt    strip_prompt=True
    Should Contain    ${out2}    password already exist    


PF TC 59 RJIO: Verify the changing of password of any user is not getting affected for other users where the username starting with same words for default user via CLI
    ${ran_username}    ${ran_password}    Generate Random username and password
    ${temp_username}    ${ran_password1}    Generate Random username and password
    Write    echo -e "eniq${ran_username}\\n${ran_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    Should Contain    ${out}    New User eniq${ran_username} created successfully
    ${tomcat_users_before}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1 | sort --unique
    ${tomcat_users_before}    Split String    ${tomcat_users_before}

    ${encryp_pass}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="eniq".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
    ${pwd_same}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
    IF    '''${pwd_same}''' =='eniq'
        Write    echo -e "eniq\\n${ran_password1}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out}    Read Until Prompt    strip_prompt=True
        Should Contain    ${out}    Password updated successfully
    ELSE
        Write
        ...    echo -e "eniq\\n${pwd_same}\\n${ran_password1}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out2}    Read Until Prompt    strip_prompt=True
        Should Contain    ${out2}    Password updated successfully
    END

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

PF TC 60 RJIO: Verify the changing of password of any user is not getting affected for other users where the username starting with same words for default user via Adminui
    ${ran_username}    ${ran_password}    Generate Random username and password
    ${temp_username}    ${ran_password1}    Generate Random username and password
    Write    echo -e "eniq${ran_username}\\n${ran_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    Should Contain    ${out}    New User eniq${ran_username} created successfully
    ${tomcat_users_before}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1 | sort --unique
    ${tomcat_users_before}    Split String    ${tomcat_users_before}

    ${encryp_pass}    Execute Command
    ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="eniq".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
    ${pwd_same}    Execute Command    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}

    Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
    Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
    Input Text    //*[@id="username"]    eniq
    Input Password    //*[@id="password"]    ${pwd_same}
    Click Button    //*[@id="submit"]
    ${IsElementVisible}    Run Keyword And Return Status
    ...    alert should be present
    ...    Alert Text: Engine is set to NoLoads
    IF    ${IsElementVisible}    handle alert    accept
    RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
    Click on scroll down button
    Click on link    Change Password
    Input Password    //*[@id="op"]    ${pwd_same}
    Input Password    //*[@id="np"]    ${ran_password1}
    Input Password    //*[@id="cnp"]    ${ran_password1}
    Select Show Password
    Click On Submit Button
    Capture Page Screenshot    embed=True
    Wait Until Keyword Succeeds    5x    30sec    wait until page contains    Management Interface    1000s
    # Validate the update message    ${paswordChangeMsg}
    Logout from Adminui if logged in
    Close Browser
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

PF TC 61 RJIO: Verify the changing of password of any user is not getting affected for other users where the username starting with same words for created new user via CLI
    ${user}    ${temp}    Generate Random username and password
    @{user_list}    Create List    rjio${user}1    rjio${user}2
    FOR    ${users}    IN    @{user_list}
        ${get_users}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep "\\b${users}\\b"
        ${check_users_status}    Run Keyword And Return Status    Should Not Be Empty    ${get_users}
        IF    "${check_users_status}"=="False"
            ${new_pass}    Changing the password for adminui
            Write    echo -e "${users}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
            ${out}    Read Until Prompt    strip_prompt=True
            Should Contain    ${out}    New User ${users} created successfully
        END
    END

    ${tomcat_users_before}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
    ${tomcat_users_list_before}    Split String    ${tomcat_users_before}
    Sort List    ${tomcat_users_list_before}
    FOR    ${user_same}    IN    @{user_list}
        ${encryp_pass}    Execute Command
        ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user_same}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
        ${pwd_same}    Execute Command
        ...    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
        ${new_password}    Changing the password for adminui
        Write
        ...    echo -e "${user_same}\\n${pwd_same}\\n${new_password}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A CHANGE_PASSWORD
        ${out2}    Read Until Prompt    strip_prompt=True
        Should Contain    ${out2}    Password updated successfully
        ${tomcat_users_after}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
        ${tomcat_users_list_after}    Split String    ${tomcat_users_after}
        Sort List    ${tomcat_users_list_after}
        Lists Should Be Equal    ${tomcat_users_list_before}    ${tomcat_users_list_after}
    END

PF TC 62 RJIO: Verify the changing of password of any user is not getting affected for other users where the username starting with same words for created new user via AdminUI
    ${user}    ${temp}    Generate Random username and password
    ${new_password}    Changing the password for adminui
    @{user_list}    Create List    plat${user}1    plat${user}2
    FOR    ${users}    IN    @{user_list}
        ${get_users}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep "\\b${users}\\b"
        ${check_users_status}    Run Keyword And Return Status    Should Not Be Empty    ${get_users}
        IF    "${check_users_status}"=="False"
            ${new_pass}    Changing the password for adminui
            Write    echo -e "${users}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
            ${out}    Read Until Prompt    strip_prompt=True
            Should Contain    ${out}    New User ${users} created successfully
        END
    END

    ${tomcat_users_before}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
    ${tomcat_users_list_before}    Split String    ${tomcat_users_before}
    Sort List    ${tomcat_users_list_before}
    FOR    ${user_same}    IN    @{user_list}
        ${encryp_pass}    Execute Command
        ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${user_same}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
        ${pwd_same}    Execute Command
        ...    bash /eniq/sw/platform/repository*/bin/EncryptDecryptUtility.sh -d ${encryp_pass}
        ${new_password}    Changing the password for adminui
        Open Available Browser    ${Login_AdminUI_URL}    options=set_capability("acceptInsecureCerts", True)
        Maximize Browser Window
        Wait Until Page Contains Element    //*[@id="username"]    timeout=100s
        Input Text    //*[@id="username"]    ${user_same}
        Input Password    //*[@id="password"]    ${pwd_same}
        Click Button    //*[@id="submit"]
        ${IsElementVisible}    Run Keyword And Return Status
        ...    alert should be present
        ...    Alert Text: Engine is set to NoLoads
        IF    ${IsElementVisible}    handle alert    accept
        RPA.Browser.Selenium.Wait Until Page Contains    HARDWARE    timeout=100s
        Click on scroll down button
        Click on link    Change Password
        Input Password    //*[@id="op"]    ${pwd_same}
        Input Password    //*[@id="np"]    ${new_password}
        Input Password    //*[@id="cnp"]    ${new_password}
        Select Show Password
        Click On Submit Button
        Validate the update message    ${paswordChangeMsg}
        wait until page contains    Management Interface    1000s
        Logout from Adminui if logged in
        Close Browser
        ${tomcat_users_after}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | cut -d " " -f1
        ${tomcat_users_list_after}    Split String    ${tomcat_users_after}
        Sort List    ${tomcat_users_list_after}
        Lists Should Be Equal    ${tomcat_users_list_before}    ${tomcat_users_list_after}
    END

PF TC 63 RJIO: Verify if we are removing a user, then is it getting removed or not from history.properties file
    ${new_user}    ${new_pass}    Generate Random username and password
    ${USER}    Set Local Variable    ${new_user}
    Write    echo -e "${new_user}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    Write    echo -e "${new_user}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A REMOVE_USER
    ${out1}    Read Until Prompt    strip_prompt=True
    ${history_file_verify}    ${rc}    Execute Command
    ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep -i "${new_user}"
    ...    return_rc=True
    IF    '${rc}' == '0'
        Fail    user was not removed from tomcat_users_history.properties file.
    ELSE
        Log    Removed the user successfully from tomcat_users_history.properties.
    END


*** Keywords ***
Create Random user
    ${new_user}    ${new_pass}    Generate Random username and password
    Set suite Variable    ${new_user}
    Set suite Variable    ${new_pass}
    Write
    ...    date +"%Y%m%d%H%M%S"; echo -e "${new_user}\\n${new_pass}\\n"| /eniq/sw/installer/manage_tomcat_user.bsh -A ADD_USER
    ${out}    Read Until Prompt    strip_prompt=True
    IF    'successfully' in '''${out}'''
        ${timestamp}    Get Regexp Matches    ${out}    \\d+
        ${decryp_pass}    Execute Command
        ...    cat /eniq/sw/runtime/apache-tomcat*/conf/tomcat-users.xml | grep -oP '<user username="${new_user}".*?/>' | grep -oP 'password="{ENCRYPTION}\\K[^"]+'
        ${history_file_verify}    ${rc}    Execute Command
        ...    cat /eniq/sw/runtime/tomcat/conf/tomcat_users_history.properties | grep -i "${new_user}" | grep -i ${timestamp}[0]
        ...    return_rc=True
        IF    '${rc}' == '0'
            Log To Console    History file verified and usename and timestamp is matching.
        ELSE
            Fail    Error, timestamp mismatch. Verify the files.
        END
    ELSE
        Fail    Error while creating new user, below is the output${\n}${decryp_pass}
    END

Create connection
    # Open Connection
    # ...    ${SERVER}.athtem.eei.ericsson.se
    # ...    port=2251
    # ...    timeout=100s
    # Login    dcuser    Dcuser%12
    # Set Client Configuration    30    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#
    Connect to physical server

Generate Random username and password
    ${username}    Generate Random String    5    [LETTERS]
    ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    RETURN    ${username}    ${password}

Changing the password for adminui
    ${password}    Generate Random String    8-15    [LETTERS][NUMBERS]
    RETURN    ${password}

Suite teardown steps
    Close All Connections
